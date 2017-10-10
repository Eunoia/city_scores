# config/initializers/resque.rb
Resque.logger.level = Logger::DEBUG
ENV["REDISTOGO_URL"] ||= "redis://localhost:6379"

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :username => uri.user)
Resque.redis = REDIS