# encoding: UTF-8
module MongoMapper
  module Extensions
    module Boolean
      Mapping = {
        true    => true,
        'true'  => true,
        'TRUE'  => true,
        'True'  => true,
        't'     => true,
        'T'     => true,
        '1'     => true,
        1       => true,
        1.0     => true,
        false   => false,
        'false' => false,
        'FALSE' => false,
        'False' => false,
        'f'     => false,
        'F'     => false,
        '0'     => false,
        0       => false,
        0.0     => false,
        nil     => nil
      }

      def to_mongo(value)
        Mapping[value]
      end

      def from_mongo(value)
        return nil if value == nil
        !!value
      end
    end
  end
end

class Boolean; end unless defined?(Boolean)

Boolean.extend MongoMapper::Extensions::Boolean
