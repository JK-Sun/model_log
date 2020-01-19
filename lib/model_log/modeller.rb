module ModelLog
  module Modeller
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def model_log
        before_create :model_log_create
        before_update :model_log_update
        after_destroy :model_log_destroy
      end
    end

    private

    def model_log_create
      model_log_write(self, :create)
    end

    def model_log_update
      model_log_write(self, :update)
    end

    def model_log_destroy
      model_log_write(self, :destroy)
    end

    def model_log_write(resource, action)
      ModelLog.logger.info Log::Content.new(resource, action, ModelLog.config.formatter).content
    rescue => ex
      ModelLog.logger.error "#{ex.class}: #{ex.message}"
    end
  end
end

ActiveRecord::Base.send(:include, ModelLog::Modeller) if defined? ActiveRecord::Base
