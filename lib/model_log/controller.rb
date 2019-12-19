module ModelLog
  module Controller
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        set_model_log_stroe
      end
    end

    module ClassMethods
      def set_model_log_stroe
        before_action :set_current_user
        before_action :set_current_requester
      end
    end

    private

    def set_current_user
      Store.clear_current_user!
      Store.current_user = send(ModelLog.current_user_fn) rescue nil
    end

    def set_current_requester
      Store.clear_current_requester!
      Store.current_requester = request.is_a?(ActionDispatch::Request) && request rescue nil
    end
  end
end

ActionController::Base.send(:include, ModelLog::Controller) if defined? ActionController::Base
