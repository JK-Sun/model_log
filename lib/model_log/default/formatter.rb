module ModelLog
  module Default
    class Formatter
      include Helpers::Context

      def call
        return unless changed?
        content = []
        content += thread_content
        content += requester_content if requester
        content += user_content if current_user
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
          requester.request_method,
          requester.url,
          requester.referer,
          requester.remote_ip,
          requester.user_agent
        ]
      end

      def user_content
        [
          current_user.send(ModelLog.config.identity_field)
        ]
      end

      def action_content
        [
          action.upcase
        ]
      end

      def resource_content
        [
          resource.class.name,
          resource.id,
          changes
        ]
      end
    end
  end
end
