module Redispatcher
  class Dispatcher
    include ActiveSupport::Callbacks
    include Logger

    define_callbacks :initialize, :process, :commit, :rollback

    set_callback :commit, :after do
      log "successfully dispatched"
    end

    set_callback :rollback, :after do
      log "dispatching failed"
    end

    attr_accessor :options, :object, :processed_object

    def initialize(object, options={})
      @object = object
      @options = options
      run_callbacks :initialize do
        log "initialize callback"
      end
    end

    def process
      run_callbacks :process do
        log "process callback"
      end
    end

    def commit
      run_callbacks :commit do
        log "commit callback"
      end
      processed_object
    end

    def rollback
      run_callbacks :rollback do
        log "rollback callback"
      end
    end

    class << self
      def dispatch(object, options={})
        @dispatcher = new(object, options)

        begin
          @dispatcher.process
        rescue DispatcherSuppressedError => e
          log e
          return nil
        end

        begin
          return @dispatcher.commit
        rescue Exception => e
          log e
          @dispatcher.rollback
          raise e
        end
      end
    end
  end
end
