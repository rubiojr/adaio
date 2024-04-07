# Adafruit IO Crystal client library

## Usage

```crystal
require "adaio"

client = AdaIO::Client.new(
  username: "changeme",
  key: "changeme"
)

client.feeds.each do |feed|
  puts "#{feed.name}: #{feed.last_value}"
end
```
