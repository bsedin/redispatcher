<%- module_namespacing do -%>
  <%- if parent_class_name.present? -%>
class <%= class_name %>Dispatcher < <%= parent_class_name %>
  <%- else -%>
class <%= class_name %>
  <%- end -%>
  # Now define some callbacks, for example:
  #
  # after_initialize do
  #   @processed_object = {}
  # end
  #
  # before_process do
  #   @processed_object.merge!(title: object.title, created_at: object.created_at)
  # end
  #
  # after_commit do
  #   File.open('/tmp/dispatcher.json', 'w') do
  #     f.write(JSON.pretty_generate(processed_object))
  #     f.close
  #   end
  #   object.update_attributes(dispatched_at: Time.now)
  # end
  #
  # after_rollback do
  #   puts 'Oh snap!'
  # end
end
<% end -%>
