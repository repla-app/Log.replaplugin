require_relative '../bundle/bundler/setup'

module Repla
  module Log
    # View
    class View < Repla::View
      ROOT_ACCESS_DIRECTORY = File.join(__dir__, '../html')
      VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'index.html')
      DARK_VIEW_TEMPLATE = File.join(ROOT_ACCESS_DIRECTORY, 'dark.html')

      def initialize
        super
        self.root_access_directory_path = File.expand_path(
          ROOT_ACCESS_DIRECTORY
        )
        template = dark_mode ? DARK_VIEW_TEMPLATE : VIEW_TEMPLATE
        load_file(template)
      end

      def log_error(message)
        do_javascript_function('error', [message])
      end

      def log_message(message)
        do_javascript_function('message', [message])
      end
    end
  end
end
