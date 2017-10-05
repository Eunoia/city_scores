require 'open-uri'

j = 0
begin
	while 1 do
		i = Time.now
		print j+=1
		url = 'https://bikeangels-api.citibikenyc.com/bikeangels/v1/scores'
		File.write("data/scores_#{i.strftime("%F_%T")}.json", open(url).read)
		print "."
		sleep 10 * rand(1, 120)
	end
rescue StandardError => e
	sleep 10
	retry
end


