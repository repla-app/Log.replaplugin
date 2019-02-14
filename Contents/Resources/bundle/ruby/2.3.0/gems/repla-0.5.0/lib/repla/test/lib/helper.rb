require 'Shellwords'
require_relative '../../lib/escape'

module Repla
  module Test
    # Test helper
    module Helper
      using Escape

      APPLESCRIPT_DIRECTORY = File.join(File.dirname(__FILE__), '..',
                                        'applescript')

      def self.run_javascript(javascript)
        # `osascript` requires redirecting stderr to stdout for some reason
        `osascript -l JavaScript -e \
        #{Shellwords.escape(javascript)} 2>&1`.chomp!
        # return `node -e #{Shellwords.escape(javascript)}`
      end

      CONFIRMDIALOGAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                                'confirm_dialog.applescript')
      def self.confirm_dialog
        run_applescript(CONFIRMDIALOGAPPLESCRIPT_FILE)
        sleep TEST_PAUSE_TIME # Give dialog time
      end

      WINDOWIDAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                           'window_id.applescript')
      def self.window_id
        run_applescript(WINDOWIDAPPLESCRIPT_FILE)
      end

      CANCELDIALOGAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                               'cancel_dialog.applescript')
      def self.cancel_dialog
        run_applescript(CANCELDIALOGAPPLESCRIPT_FILE)
        sleep TEST_PAUSE_TIME # Give dialog time
      end

      QUITAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                       'quit.applescript')
      def self.quit
        run_applescript(QUITAPPLESCRIPT_FILE)
      end

      ISRUNNINGAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                            'is_running.applescript')
      def app_running?
        result = run_applescript(ISRUNNINGAPPLESCRIPT_FILE)
        result == 'true'
      end

      SWITCHWINDOWSAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                                'switch_windows.applescript')
      def self.switch_windows
        run_applescript(SWITCHWINDOWSAPPLESCRIPT_FILE)
      end

      WINDOWBOUNDSAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                               'window_bounds.applescript')
      def self.window_bounds(window_id = nil)
        run_applescript(WINDOWBOUNDSAPPLESCRIPT_FILE, [window_id])
      end

      SETWINDOWBOUNDSAPPLESCRIPT_FILE = File.join(APPLESCRIPT_DIRECTORY,
                                                  'set_window_bounds'\
                                                  '.applescript')
      def self.set_window_bounds(bounds, window_id = nil)
        arguments = [bounds]
        arguments = arguments.push(window_id) if window_id
        run_applescript(SETWINDOWBOUNDSAPPLESCRIPT_FILE, arguments)
      end

      private

      private_class_method def self.run_applescript(script, arguments = nil)
        command = "osascript #{Shellwords.escape(script)}"
        if arguments
          arguments.each do |argument|
            if argument
              argument = argument.to_s
              command = command + ' ' + Shellwords.escape(argument)
            end
          end
        end

        result = `#{command}`

        result.chomp!

        return nil if result.empty?

        return result.to_i if result.integer?

        return result.to_f if result.float?

        result
      end
    end
  end
end