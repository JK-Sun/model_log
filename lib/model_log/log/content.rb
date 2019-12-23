module ModelLog
  module Log
    class Content < Base
      def content
        return if is_update? && @resource.changes.empty?
        content = []
        content += thread_content
        content += requester_content if ModelLog.requester_exist?
        content += user_content if ModelLog.current_user_exist?
        content += action_content
        content += resource_content
        content.join(ModelLog.config.separator)
      end

      private

      def thread_content
        [
          Thread.current.object_id
        ]
      end

      def requester_content
        [
          ModelLog.requester.request_method,
          ModelLog.requester.url,
          ModelLog.requester.referer,
          ModelLog.requester.remote_ip,
          ModelLog.requester.user_agent
        ]
      end

      def user_content
        [
          ModelLog.current_user.send(ModelLog.config.identity_field)
        ]
      end

      def action_content
        [
          @action.upcase
        ]
      end

      def resource_content
        [
          @resource.class.name,
          @resource.id,
          Processor.new(@resource, @action).data
        ]
      end
    end
  end
end
