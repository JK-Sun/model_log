require "model_log/version"
require "model_log/passport"
require "model_log/request"
require "model_log/class_methods/models"
require "model_log/class_methods/controllers"

module ModelLog
  class << self
    attr_accessor :platform, :current_user_method, :user_name_field

    def info(content)
      content = content.chomp + "\n"
      File.open("log/model_log_#{Rails.env}.log", "a+") do |output|
        output.write(content)
      end
    end
  end

  @current_user_method = @current_user_method || :current_passport
  @user_name_field = @user_name_field || :username
end

