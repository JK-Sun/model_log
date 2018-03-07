module ModelLog
  module ClassMethods
    module Controllers
      def self.included(base)
        base.class_eval do
          extend Invoking
          model_log_user_setting
        end
      end

      module Invoking
        def model_log_user_setting
          before_action :set_current_passport
          before_action :set_current_request
        end
      end

      private

        def set_current_passport
          ModelLog::Passport.clear_current_passport!
          ModelLog::Passport.current_passport = send(ModelLog.current_user_method)
        end

        def set_current_request
          ModelLog::Request.clear_current_request!
          ModelLog::Request.current_request = request
        end
    end
  end
end

ActionController::Base.send(:include, ModelLog::ClassMethods::Controllers) if defined? ActionController::Base
