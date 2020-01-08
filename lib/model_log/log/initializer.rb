module ModelLog
  module Log
    module Initializer
      attr_accessor :resource, :action
      # {
      #   resource:     object_active_record,
      #   action:       create|update|destroy,
      # }
      def initialize(resource, action)
        @resource = resource
        @action = action
        verify_action!
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
