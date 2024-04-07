require "../src/client.cr"
require "yaml"

config = File.open(File.join(Path.home, ".config/adaio/config.yaml")) do |file|
  YAML.parse(file)
end

client = AdaIO::Client.new(
  username: config["username"].as_s,
  key: config["key"].as_s
)

client.feeds.each do |feed|
  local_time = feed.updated_at.in(Time::Location.local)
  puts "[#{local_time.to_s("%Y-%m-%d %H:%m")}] #{feed.name}: #{format(feed)}"
end

# https://www.who.int/news-room/fact-sheets/detail/ambient-(outdoor)-air-quality-and-health
# https://www.airthings.com/resources/pm-size-difference
# https://environment.ec.europa.eu/topics/air/air-quality/eu-air-quality-standards_en
def format(pm)
  case pm.name
  when /.*-temperature/
    "#{pm.last_value}°C"
  when "urbansensor-pm2-5"
    return "#{pm.last_value.colorize(:green)} µg/m3" if pm.last_value.to_i < 15
    "#{pm.last_value} (>= 15 µg/m3)".colorize(:red)
  when "urbansensor-pm10"
    return "#{pm.last_value.colorize(:green)} µg/m3" if pm.last_value.to_i < 45
    "#{pm.last_value} (=> 45 µg/m3)".colorize(:red)
  when "urbansensor-pm1"
    return "#{pm.last_value.colorize(:green)} µg/m3" if pm.last_value.to_i < 10
    "#{pm.last_value} (>= 10 µg/m3)".colorize(:red)
  when "urbansensor-noise"
    return "#{pm.last_value.colorize(:green)} µg/m3" if pm.last_value.to_f < 0.070
    "#{pm.last_value} (>= 70 dBA)".colorize(:red)
  when "urbansensor-humidity"
    "#{pm.last_value}%"
  else
    pm.last_value
  end
end
