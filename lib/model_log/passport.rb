module ModelLog
  module Passport
    class << self
      def current_passport
        Thread.current[:passport]
      end

      def current_passport=(value)
        Thread.current[:passport] = value
      end

      def clear_current_passport!
        Thread.current[:passport] = nil
      end
    end
  end
end

