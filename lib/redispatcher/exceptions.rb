module Redispatcher
  class DispatcherError < RuntimeError; end
  class DispatcherSuppressedError < DispatcherError; end
  class UninferrableDispatcherError < DispatcherError; end
end
