module Api::V1
	class RoutesController < ApplicationController
		def index
			most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
			render json: Station.joins(:scores).where("scores.created_at = ? and stations.region_id=71", most_recent_date).select("stations.id, stations.name, stations.lat, stations.lon, stations.geog, scores.score").as_json
		end

		def segments
			redis = Resque.redis.redis
			links = redis.get('links')
			if links.nil?
				links = Station.links
				n = DateTime.now
				b = DateTime.now.beginning_of_hour
				e = DateTime.now.end_of_hour
				hour_half = (b + 30.minutes) > n ? (b + 30.minutes) : e
				ttl = ((n - hour_half).abs * 24 * 60 * 60).to_i
				redis.setex("links", ttl, links.to_json)
			end
			render json: links
		end
	end
end
