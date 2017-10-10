# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'resque/tasks'
Rails.application.load_tasks

task 'resque:setup' => :environment

task :get_scores => :environment do
	require 'open-uri'
	cols = %i(station_id score)
	url = 'https://bikeangels-api.citibikenyc.com/bikeangels/v1/scores'
	Score.import cols, JSON.parse(open(url).read)['stations'].to_a
	puts Score.select("max(created_at) as created_at")[0].created_at.iso8601(6)
end

task :import_stations => :environment do
	require 'open-uri'
	url = 'https://gbfs.citibikenyc.com/gbfs/en/station_information.json'
	json = JSON.parse(open(url).read)#'stations'].to_a
	keys = %w(station_id name short_name lat lon region_id capacity rental_url)
	stations = json["data"]["stations"].map{ |d| d.slice(*keys).values unless d["name"]=~/soon/i }.compact
	keys[0] = "id"
	# binding.pry
	Station.import keys, stations
end

task :upgrade_geog => :environment do
	Station.where(geog:nil).each do |s|
		s.geog =  "POINT(#{s.lon} #{s.lat})"
		s.save!
	end
end

task :enqueue_cost_lookups => :environment do
	pairs = Station.pluck(:id).repeated_permutation(2).to_a.select{ |i,j| i!=j }.shuffle
	puts "Wow! So many pairs: #{pairs.length}"
	pairs.each do |pair|
		ap GenerateRouteCostJob.perform_now(*pair)
	end
end
