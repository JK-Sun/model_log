module ModelLog
  module Log
    module Initializer
      attr_reader :resource, :changes, :attributes, :changed_attributes, :action

      # params
      # resource: object_active_record
      # action:   create|update|destroy
      def initialize(resource, action)
        @action             = action
        verify_action!

        @resource           = resource
        @changes            = resource.changes
        @changed_attributes = resource.changed_attributes
        @attributes         = resource.attributes
        @is_changed         = resource.changed?
      end

      def changd?
        @is_changed
      end

      private

      def verify_action!
        unless %i(create destroy update).include? action
          raise StandardError, "invalid action given #{action}"
        end
      end
    end
  end
end
