require 'active_support/callbacks'
require 'active_support/concern'
require_relative 'redispatcher/exceptions'
require_relative 'redispatcher/dispatchable'
require_relative 'redispatcher/callbacks'
require_relative 'redispatcher/logger'
require_relative 'redispatcher/dispatcher'
require_relative 'redispatcher/dispatchable_method'
require_relative 'redispatcher/railtie' if defined? Rails

module Redispatcher
  def self.setup_orm(base)
    base.class_eval do
      extend Redispatcher::DispatchableMethod
    end
  end
end
