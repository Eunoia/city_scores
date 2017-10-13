class Station < ApplicationRecord
	has_many :scores
	def link
		most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
		sql =<<~SQL
			with subj as (select stations.*, scores.score from stations
			left join scores on scores.station_id = stations.id 
			where scores.created_at = '#{most_recent_date}' 
			and stations.id='#{id}')

			select 
			subj.id, stations.id,
			stations.id as sid, abs(subj.score) + abs(scores.score) as value,
			(st_distance(stations.geog, subj.geog) / 133.333 ) as cost, 
			costs.time/60 as costed_time,
			--(((abs(subj.score) + abs(scores.score))*.1)/(1+st_distance(stations.geog, subj.geog) / 133.333 ))*60 as wage,
			(((abs(subj.score) + abs(scores.score))*.1)/(1+st_distance(stations.geog, subj.geog) / 133.333 ))*60 as wage,
			stations.name,  stations.lat, stations.lon, scores.score
			from stations
			cross join subj 
			left join scores on scores.station_id = stations.id 
			left join costs on (costs.left_id = subj.id and costs.right_id = stations.id)
			where (scores.score>=1) --subj.station_id = scores.station_id or 
			and scores.created_at = '#{most_recent_date}'
			and subj.id != stations.id
			and stations.region_id=71 order by 7 desc
			limit 1
		SQL
		Station.connection.execute(sql)[0].merge(subj_id: id, subj_name: name, subj_lat: lat, subj_lon: lon).to_h
	end
end

# Example:
# Score.where(created_at: '2017-10-09 00:12:03.411055') # Get the latest scores
#  .where("score < 0") # where stations can be picked up from
#  .pluck(:station_id).map{ |sid|  # For each of those stations
#    Station.find(sid).link.to_a  # Get the most optimal drop off station
#		}.map(&:to_h).sort_by{ |s| s["wage"] };nil # sort all stations by possible money
