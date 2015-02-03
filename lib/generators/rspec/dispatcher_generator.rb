module Rspec
  class DispatcherGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_spec_file
      template 'dispatcher_spec.rb', File.join('spec/dispatchers', class_path, "#{singular_name}_dispatcher_spec.rb")
    end
  end
end
