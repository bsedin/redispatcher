module Redispatcher
  module Logger
    # Log a dispatcher-specific line. This will log to STDOUT
    # by default.
    # Set Dispatcher.options[:log] to false to turn off.
    def log(message)
      logger.info("[redispatcher] #{message}") if logging?
    end

    def logger #:nodoc:
      @logger ||= options[:logger] || ::Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end

    def logging? #:nodoc:
      options[:log]
    end
  end
end
