module Redispatcher
  module Callbacks
    extend ActiveSupport::Concern

    included do
      define_callbacks :dispatch¬

      def before_dispatch(*args, &blk)
        set_callback(:dispatch, :before, *args, &blk)
      end

      def after_dispatch(*args, &blk)
        set_callback(:dispatch, :after, *args, &blk)
      end
    end
  end
end
