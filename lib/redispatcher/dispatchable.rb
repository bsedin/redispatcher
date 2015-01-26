module Redispatcher
  module Dispatchable
    module InstanceMethods
      extend ActiveSupport::Concern

      # Decorates the object using the inferred {#dispatcher_class}.
      # @param [Hash] options
      #   see {Redispatcher::Dispatcher#initialize}
      def dispatch(options = {})
        dispatcher_class.dispatch(self, options)
      end

      # (see Dispatchable::ClassMethods#dispatcher_class)
      def dispatcher_class
        self.class.dispatcher_class
      end

      def dispatcher_class?
        self.class.dispatcher_class?
      end
    end

    module ClassMethods
      def dispatcher_class?
        dispatcher_class
      rescue Redispatcher::UninferrableDispatcherError
        false
      end

      # Infers the dispatcher class `Topic` maps to `TopicRedispatcher`).
      # @return [Class] the inferred dispatcher class.
      def dispatcher_class
        prefix = respond_to?(:model_name) ? model_name : name
        dispatcher_name = "#{prefix}Dispatcher"
        dispatcher_name.constantize
      rescue NameError => error
        if superclass.respond_to?(:dispatcher_class)
          superclass.dispatcher_class
        else
          raise unless error.missing_name?(dispatcher_name)
          raise Redispatcher::UninferrableDispatcherError.new(self)
        end
      end
    end
  end
end
