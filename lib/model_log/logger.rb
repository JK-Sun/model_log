#require "active_support"

module ModelLog
  class Logger < ::ActiveSupport::Logger
    def initialize(log_name = 'model_log', path = "")
      log_path = File.join(Rails.root, 'log', path.to_s, "#{log_name}")
      super(log_path)
    end

    LEVELS = %i(debug info warn error fatal unknown).freeze

    LEVELS.each do |level|
      define_method level do |msg|
        super("[#{Time.current.strftime('%Y-%m-%d %H:%M:%S')}] #{level.upcase} -- : #{msg}")
      end
    end
  end
end
