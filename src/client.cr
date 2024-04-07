require "crest"
require "json"
require "./models/*"

module AdaIO
  class Client
    def initialize(@username : String = ENV["ADAFRUIT_IO_USERNAME"], @key : String = ENV["ADAFRUIT_IO_KEY"])
    end

    def get(path : String, params = {} of String => String) : String
      res = Crest.get(
        "https://io.adafruit.com/api/v2#{path}",
        params: params,
        headers: {
          "Accept"    => "application/json",
          "X-AIO-Key" => @key,
        }
      )
      res.body
    end

    def feeds : Array(Models::Feed)
      feeds = get("/#{@username}/feeds")
      Array(Models::Feed).from_json(feeds)
    end
  end
end
