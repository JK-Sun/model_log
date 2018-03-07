module ModelLog
  module Request
    class << self
      def current_request
        Thread.current[:request]
      end

      def current_request=(value)
        Thread.current[:request] = value
      end

      def clear_current_request!
        Thread.current[:request] = nil
      end
    end
  end
end
