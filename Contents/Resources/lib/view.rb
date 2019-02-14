require_relative '../bundle/bundler/setup'

module WebConsole::Log
  class View < WebConsole::View

    ROOT_ACCESS_DIRECTORY = File.join(File.dirname(__FILE__), '../html')
    VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'index.html')

    def initialize
      super
      self.root_access_directory_path = File.expand_path(ROOT_ACCESS_DIRECTORY)
      load_erb_from_path(VIEW_TEMPLATE)
    end

    def log_error(message)
      do_javascript_function("error", [message])
    end

    def log_message(message)
      do_javascript_function("message", [message])
    end

  end
end
