module ModelLog
  class Config
    attr_accessor :current_user_method, :identity_field, :separator, :formatter

    def initialize
      @current_user_method ||= :current_user
      @identity_field      ||= :id
      @separator           ||= "\t"
      @formatter           ||= Default::Formatter
    end
  end
end
