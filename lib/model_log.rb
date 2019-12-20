require "model_log/version"
require "model_log/store"
require "model_log/controller"
require "model_log/modeller"
require "model_log/logger"
require "model_log/log/base"
require "model_log/log/content"
require "model_log/log/processor"

module ModelLog
  class << self
    attr_accessor :current_user_fn, :identity_field

    def logger
      @logger ||= Logger.new("model_log_#{Rails.env}.log")
    end

    def requester
      Store.current_requester
    end

    def requester_exist?
      !!requester
    end

    def current_user
      Store.current_user
    end

    def current_user_exist?
      !!current_user
    end
  end

  @current_user_fn ||= :current_user
  @identity_field ||= :id
end

