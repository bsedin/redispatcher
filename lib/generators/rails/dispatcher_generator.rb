module Rails
  module Generators
   class DispatcherGenerator < NamedBase
      source_root File.expand_path("../templates", __FILE__)
      check_class_collision suffix: "Dispatcher"

      class_option :parent, type: :string, desc: "The parent class for the generated dispatcher"

      def create_dispatcher_file
        template 'dispatcher.rb', File.join('app/dispatchers', class_path, "#{file_name}_dispatcher.rb")
      end

      #hook_for :test_framework

      private

      def parent_class_name
        options.fetch("parent") do
          "Redispatcher::Dispatcher"
        end
      end
    end
  end
end
