module ModelLog
  module Log
    class Content
      include Initializer

      def initialize(resource, action, formatter)
        super(resource, action)
        @formatter = formatter
      end

      def content
        @formatter.new(context).call
      end

      private

      def context
        Context.new(
          current_user: ModelLog.current_user,
          requester: ModelLog.requester,
          action: @action,
          resource: @resource,
          changes: Processor.new(@resource, @action).data
        ).to_struct
      end
    end
  end
end
