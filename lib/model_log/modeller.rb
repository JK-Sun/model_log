module ModelLog
  module Modeller
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def model_log
        after_create :model_log_create
        after_destroy :model_log_destroy
        before_update :model_log_update
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
      # ModelLog.logger.debug resource.changes
      # update changes is not empty
      # create and destroy changes is empty
      if log_content(resource, action)
        ModelLog.logger.info log_content(resource, action)
      end
    rescue => ex
      ModelLog.logger.error "#{ex.class}: #{ex.message}"
    end

    def log_content(resource, action)
      @log_content ||= Log::Content.new(resource, action, ModelLog.config.formatter).content
    end
  end
end

ActiveRecord::Base.send(:include, ModelLog::Modeller) if defined? ActiveRecord::Base
