module Redispatcher
  module DispatchableMethod
    def dispatchable(options = {})
      # Check options
      raise Redispatcher::DispatcherError.new("Options for dispatchable must be in a hash.") unless options.is_a? Hash
      options.each do |key, value|
        # No options yet
        unless [:dispatcher_class].include? key
          raise Redispatcher::DispatcherError.new("Unknown option for dispatchable: #{key.inspect} => #{value.inspect}.")
        end
      end

      include Redispatcher::Callbacks
      define_dispatcher_callbacks :dispatch

      include Redispatcher::Dispatchable

      # Create dispatcher class accessor and set to option or default
      #cattr_accessor :dispatcher_class
      #self.dispatcher_class = option[:dispatcher_class]
    end
  end
end
