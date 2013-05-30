#
# Expand extension
#
# https://github.com/ncuesta/api-doc/blob/master/README.en.md#links-expansion
#
module Api
  module Extensions
    module Expand
      # Add expand_with class method on inclusion
      def self.included(base)
        @@fetch_method_for_expand = :get

        base.class_eval 'def self.expand_with(symbol); @@fetch_method_for_expand = symbol; end'
      end

      # Process the expand functional extension
      def process_expand(keys, scope)
        keys.split(',').each do |key|
          entries_parts = key.match(/entries\((.*)\)$/)

          if entries_parts && scope['entries']
            # (2) Collective key: expand=entries(self)
            scope['entries'].collect! { |entry| process_expand entries_parts[1], entry }
          else
            recursive = key.match(/([^\(]+)\((.*)\)$/)

            if recursive
              # (1) Recursive key: expand=section(parent)
              local_key, sub_key = recursive[1, 2]
              # Expand the local key
              scope = expand scope, local_key
              # Recursively expand the remaining keys - if possible
              new_scope = local_key == 'self' ? scope : scope[local_key]
              process_expand(sub_key, new_scope) if new_scope
            else
              # (0) Simple key: expand=section
              scope = expand scope, key
            end
          end
        end

        scope
      end

      # Actually expand a link
      def expand(resource, link)
        if resource['links'].include?(link)
          sub_resource_uri = resource['links'][link]['href']
          sub_resource     = send(fetch_method_for_expand, sub_resource_uri)

          # 'self' links replace the original resource
          if link == 'self'
            resource = sub_resource
          else
            resource[link] = sub_resource
          end
        end

        resource
      end

      private
        def fetch_method_for_expand
          @@fetch_method_for_expand
        end
    end
  end
end
