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
  puts "#{feed.name}: #{feed.last_value}"
end
