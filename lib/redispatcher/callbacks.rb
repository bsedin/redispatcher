module Redispatcher
  module Callbacks
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module ClassMethods
      def define_dispatcher_callbacks(*callbacks)
        define_callbacks(*callbacks.flatten)

        callbacks.each do |callback|
          eval <<-end_callbacks
            def before_#{callback}(*args, &block)
              set_callback(:#{callback}, :before, *args, &block)
            end

            def after_#{callback}(*args, &block)
              set_callback(:#{callback}, :after, *args, &block)
            end
          end_callbacks
        end
      end
    end

    module InstanceMethods
      def run_dispatcher_callbacks(callback, &block)
        run_callbacks(callback, &block)
      end
    end
  end
end
