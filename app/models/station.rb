class Station < ApplicationRecord
	has_many :scores
	def link
		sql =<<~SQL
			with subj as (select * from stations
			left join scores on scores.station_id = stations.id 
			where scores.created_at = '2017-10-10T15:09:30.489963Z' 
			and stations.id='#{id}')

			select 
			stations.id as sid, abs(subj.score) + abs(scores.score) as value,
			(st_distance(stations.geog, subj.geog) / 133.333 ) as cost, 
			(((abs(subj.score) + abs(scores.score))*.1)/(1+st_distance(stations.geog, subj.geog) / 133.333 ))*60 as wage,
			stations.name,  stations.lat, stations.lon, scores.score
			from stations
			cross join subj 
			left join scores on scores.station_id = stations.id 
			where (scores.score>=0) --subj.station_id = scores.station_id or 
			and scores.created_at = '2017-10-10T15:09:30.489963Z' 
			and stations.region_id=71 order by 4 desc
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
