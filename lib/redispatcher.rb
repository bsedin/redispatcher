require 'active_support/callbacks'
require 'active_support/concern'
require_relative 'redispatcher/exceptions'
require_relative 'redispatcher/dispatchable'
require_relative 'redispatcher/callbacks'
require_relative 'redispatcher/logger'
require_relative 'redispatcher/dispatcher'

module Redispatcher
end

class << ActiveRecord::Base
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

    after_commit :dispatch
  end
end

