require 'forwardable'

module ModelLog
  module Helpers
    module Context
      extend Forwardable

      def_delegators :@context, :current_user, :requester, :action, :resource, :changes

      def initialize(context)
        @context = context
      end

      protected

      def is_update?
        action == :update
      end

      def is_create?
        action == :create
      end

      def is_destroy?
        action == :destroy
      end

      def changed?
        !changes.empty?
      end
    end
  end
end
