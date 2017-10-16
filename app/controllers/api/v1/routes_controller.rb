module Api::V1
	class RoutesController < ApplicationController
		def index
			most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
			render json: Station.joins(:scores).where("scores.created_at = ? and stations.region_id=71", most_recent_date).select("stations.id, stations.name, stations.lat, stations.lon, stations.geo, scores.score").as_json
		end

		def segments
			render json: Station.links
		end
	end
end
