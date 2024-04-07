module AdaIO
  module Models
    class Feed
      include JSON::Serializable

      property id : Int64

      property name : String

      property last_value : String

      property status : String

      property created_at : String

      property updated_at : String
    end
  end
end
