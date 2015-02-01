require 'rails/railtie'

module Redispatcher
  class Railtie < Rails::Railtie

    config.after_initialize do |app|
      app.config.paths.add 'app/dispatcher', eager_load: true
    end

    initializer "redispatcher.setup_orm" do |app|
      [:active_record, :sequel].each do |orm|
        ActiveSupport.on_load orm do
          Redispatcher.setup_orm self
        end
      end
    end
  end
end
