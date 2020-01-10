require 'active_support'
require 'active_support/core_ext/object/blank'

require 'model_log/version'

module ModelLog
  extend ActiveSupport::Autoload

  autoload :Config,  'model_log/config'
  autoload :Store,   'model_log/store'
  autoload :Logger,  'model_log/logger'
  autoload :Context, 'model_log/context'

  module Log
    autoload :Initializer, 'model_log/log/initializer'
    autoload :Content,     'model_log/log/content'
    autoload :Processor,   'model_log/log/processor'
  end

  module Default
    autoload :Formatter, 'model_log/default/formatter'
  end

  module Helpers
    autoload :Context, 'model_log/helpers/context'
  end

  class << self
    def configure
      yield config
    end

    def config
      @_config ||= Config.new
    end

    def logger
      @_logger ||= Logger.new("model_log_#{::Rails.env}.log")
    end

    def requester
      Store.requester
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
end

require 'model_log/controller'
require 'model_log/modeller'
