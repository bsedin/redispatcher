module Redispatcher
  module Callbacks
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module ClassMethods
      def define_dispatcher_callbacks
        define_callbacks :dispatch

        eval <<-end_callbacks
          def before_dispatch(*args, &block)
            set_callback(:dispatch, :before, *args, &block)
          end

          def after_dispatch(*args, &block)
            set_callback(:dispatch, :after, *args, &block)
          end
        end_callbacks
      end
    end

    module InstanceMethods
      def run_dispatcher_callbacks(&block)
        run_callbacks(:dispatch, &block)
      end
    end
  end
end
