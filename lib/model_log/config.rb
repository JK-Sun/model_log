module ModelLog
  class Config
    attr_accessor :current_user_method, :identity_field, :separator

    def initialize
      @current_user_method ||= :current_user
      @identity_field      ||= :id
      @separator           ||= "\t"
    end
  end
end
