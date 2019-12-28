require "logger"

module ModelLog
  class Logger < ::Logger
    def initialize(filename)
      super(File.join(::Rails.root, 'log', filename))
      self.level = level
      self.datetime_format = datetime_format
      self
    end

    private

    def level
      ModelLog.config.logger_level
    end

    def datetime_format
      ModelLog.config.logger_datetime_format
    end
  end
end
