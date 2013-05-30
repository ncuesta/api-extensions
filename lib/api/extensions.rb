require 'api/extensions/expand'
require 'api/extensions/fields'
require 'api/extensions/version'

module Api
  module Extensions
    module All
      # Convenience module for including all extensions at once
      def self.included(base)
        base.class_eval %Q{
          include Api::Extensions::Expand
          include Api::Extensions::Fields
        }
      end
    end
  end
end