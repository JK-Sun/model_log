module ModelLog
  class Config
    attr_accessor :current_user_method, :identity_field, :separator, :formatter,
                  :logger_level, :logger_datetime_format

    def initialize
      @current_user_method ||= :current_user
      @identity_field      ||= :id
      @separator           ||= ' '
      @formatter           ||= Default::Formatter
      @logger_level        ||= Logger::INFO  # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    end
  end
end
