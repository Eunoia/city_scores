# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks


task :get_scores => :environment do
	require 'open-uri'
	cols = %i(station_id score)
	url = 'https://bikeangels-api.citibikenyc.com/bikeangels/v1/scores'
	Score.import cols, JSON.parse(open(url).read)['stations'].to_a
end
