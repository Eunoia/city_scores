module Api::V1
	class RoutesController < ApplicationController
		def index
			render json: Station.joins(:scores).where("scores.created_at = '2017-10-10T15:09:30.489963Z'").select("*, scores.score").as_json
		end

		def segments
			render json: Score.where(created_at: '2017-10-10T15:09:30.489963Z').where("score <= 0").pluck(:station_id).map{ |sid| Station.find(sid).link.to_a }.map(&:to_h).sort_by{ |s| s["wage"] };
		end
	end
end
