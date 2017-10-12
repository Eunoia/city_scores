require 'open-uri'

class GenerateRouteCostJob < ApplicationJob
  queue_as :default

  def perform(*args)
  	left_id, right_id = *args
  	return true if Cost.where(left_id: left_id, right_id:right_id).exists?
  	left = Station.find(left_id)
  	right = Station.find(right_id)
  	locations = [left.as_json.slice(*%w[lon lat]), right.as_json.slice(*%w[lon lat])].to_json
  	url = 'http://107.170.227.230:8002/route?json={"locations":'+locations+',"costing":"bicycle"}'
		begin
			json = JSON.parse(open(url).read) 
			length, time = json['trip']["summary"].values_at(*%w[length time])
			shape = json['trip']['legs'][0]['shape']
			Cost.create(left_id:left_id, right_id:right_id, distance:length, time: time, polyline:shape, mode:'bicycle')	
		rescue Exception => e
			return false
		end
		
  end
end

=begin
	  create_table "costs", force: :cascade do |t|
    t.integer "left_id"
    t.integer "right_id"
    t.decimal "distance"
    t.decimal "haversine"
    t.decimal "time"
    t.text "polyline"
    t.integer "mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end