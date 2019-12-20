module ModelLog
  module Log
    class Base
      # {
      #   resource:     obj_active_record,
      #   action:       create|update|destroy,
      # }
      def initialize(resource, action)
        @resource = resource
        @action = action
      end

      protected

      def is_update?
        @action == :update
      end

      def is_create?
        @action == :create
      end

      def is_destroy?
        @action == :destroy
      end
    end
  end
end
