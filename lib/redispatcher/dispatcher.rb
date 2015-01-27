module Redispatcher
  class Dispatcher
    include ActiveSupport::Callbacks
    include Callbacks
    include Logger

    define_dispatcher_callbacks(:initialize, :process, :commit, :rollback)

    after_commit do
      log "successfully dispatched"
    end

    after_rollback do
      log "dispatching failed"
    end

    attr_accessor :options, :object, :processed_object

    def initialize(object, options={})
      @object = object
      @options = options
      run_dispatcher_callbacks :initialize do
        log "initialize callback"
      end
    end

    def process
      run_dispatcher_callbacks :process do
        log "process callback"
      end
    end

    def commit
      run_dispatcher_callbacks :commit do
        log "commit callback"
      end
      processed_object
    end

    def rollback
      run_dispatcher_callbacks :rollback do
        log "rollback callback"
      end
    end

    class << self
      attr_accessor :instance

      def dispatch(object, options={})
        @instance = new(object, options)

        begin
          instance.process
        rescue DispatcherSuppressedError => e
          instance.log e
          return nil
        end

        begin
          return instance.commit
        rescue Exception => e
          instance.log e
          instance.rollback
          raise e
        end
      end
    end
  end
end
