module Api::V1
	class RoutesController < ApplicationController
		def index
			most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
			render json: Station.joins(:scores).where("scores.created_at = ?", most_recent_date).select("*, scores.score").as_json
		end

		def segments
			most_recent_date = Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
			render json: Score.where(created_at: most_recent_date).where("score <= 0").pluck(:station_id).map{ |sid| Station.find(sid).link.to_a }.map(&:to_h).sort_by{ |s| s["wage"]||-1 };
		end
	end
end
