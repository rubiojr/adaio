module AdaIO
  module Models
    class Feed
      include JSON::Serializable

      property id : Int64

      property name : String

      property last_value : String

      property status : String

      property created_at : Time

      property updated_at : Time
    end
  end
end
