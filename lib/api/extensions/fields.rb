#
# Fields extension
#
# https://github.com/ncuesta/api-doc/blob/master/README.en.md#partial-responses
#
module Api
  module Extensions
    module Fields
      # Process the fields functional extension
      def process_fields(keys, response, full_link = nil)
        fields = parse_fields keys
        response.reject! { |k, v| !fields.include? k } if fields.length > 0
        response['links']['full'] = { 'href' => full_link } unless full_link.nil?

        response
      end

      # Parse a string for the fields functional extension
      #   - Add the required fields if not present
      def parse_fields(fields_string)
        required_fields + fields_string.split(',')
      end

      # Get the required fields for any response
      def required_fields
        ['links']
      end
    end
  end
end
