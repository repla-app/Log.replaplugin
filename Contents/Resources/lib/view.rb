require_relative '../bundle/bundler/setup'

module Repla::Log
  class View < Repla::View
    ROOT_ACCESS_DIRECTORY = File.join(File.dirname(__FILE__), '../html')
    VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'index.html')

    def initialize
      super
      self.root_access_directory_path = File.expand_path(ROOT_ACCESS_DIRECTORY)
      load_file(VIEW_TEMPLATE)
    end

    def log_error(message)
      do_javascript_function('error', [message])
    end

    def log_message(message)
      do_javascript_function('message', [message])
    end
  end
end
