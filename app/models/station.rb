class Station < ApplicationRecord
	has_many :scores
	def self.links
		most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
		sql =<<~SQL
			with subj as (select stations.*, scores.score from stations
			left join scores on scores.station_id = stations.id 
			where scores.created_at = '#{most_recent_date}' 
			and stations.region_id=71
			and scores.score<=0),

			pass1 as (
			select 
			subj.id, stations.id,
			stations.id as sid, 
			-- abs(subj.score) + abs(scores.score) as value,
			-- (st_distance(stations.geog, subj.geog) / 133.333 ) as cost, 
			st_distance(stations.geog, subj.geog) as crow,
			-- (((abs(subj.score) + abs(scores.score))*.1)/(1+st_distance(stations.geog, subj.geog) / 133.333 ))*60 as wage,    
			(((abs(subj.score) + abs(scores.score))*.1)/coalesce(costs.time, (1+st_distance(stations.geog, subj.geog) / 133.333 )))*60 as wage,
			-- costs.distance as costed_distance,
			-- st_distance(stations.geog, subj.geog) as st_dist,
			rank() OVER (partition by subj.id order by (((abs(subj.score) + abs(scores.score))*.1)/(coalesce(costs.time, (1+st_distance(stations.geog, subj.geog) / 133.333 )))*60)+2 desc),
			stations.name,  stations.lat, stations.lon, scores.score,
						costs.distance as manahat,
			costs.time/60 as costed_time,
			costs.polyline as polyline, subj.id as subj_id, subj.name as subj_name, subj.lat as subj_lat, subj.lon as subj_lon
			from stations
			cross join subj 
			left join scores on scores.station_id = stations.id 
			join costs on (costs.left_id = subj.id and costs.right_id = stations.id)
			where (scores.score>=0 and scores.score > subj.score) --subj.station_id = scores.station_id or 
			and scores.created_at = '#{most_recent_date}'
			and subj.id != stations.id
			and stations.region_id=71 order by 7 desc
			)
			select * from pass1 where rank=1 order by score desc, costed_time desc;
		SQL
		
		Station.connection.execute(sql).to_a
	end
end
