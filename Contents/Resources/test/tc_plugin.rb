#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative 'lib/test_constants'

require_relative '../bundle/bundler/setup'
require 'repla/logger'

require 'repla/test'
require Repla::Test::HELPER_FILE
require Repla::Test::REPLA_FILE

require_relative 'lib/test_helper'

# Test plugin
class TestPlugin < Minitest::Test
  MESSAGE_PREFIX = Repla::Logger::MESSAGE_PREFIX
  ERROR_PREFIX = Repla::Logger::ERROR_PREFIX

  def setup
    Repla.load_plugin(TEST_PLUGIN_PATH)
    window_id = Repla.run_plugin(TEST_PLUGIN_NAME, TEST_PLUGIN_PATH)
    @window = Repla::Window.new(window_id)
    @test_helper = Repla::Log::Test::TestHelper.new(@window)
  end

  def teardown
    @window.close
  end

  # Tests

  def test_log_title
    title = nil
    Repla::Test.block_until do
      title = @window.do_javascript(TEST_TITLE_JAVASCRIPT)
      title == TEST_PLUGIN_NAME
    end
    assert_equal(title, TEST_PLUGIN_NAME)
  end

  def test_log
    # Test Error
    message = 'Testing log error'
    input = ERROR_PREFIX + message
    @window.read_from_standard_input(input + "\n")
    test_message = nil
    Repla::Test.block_until do
      test_message = @test_helper.last_log_message
      test_message == message
    end
    assert_equal(message, test_message)
    test_class = @test_helper.last_log_class
    assert_equal('error', test_class)

    # Test Message
    message = 'Testing log message'
    input = MESSAGE_PREFIX + message
    @window.read_from_standard_input(input + "\n")
    test_message = nil
    Repla::Test.block_until do
      test_message = @test_helper.last_log_message
      test_message == message
    end
    assert_equal(message, test_message)
    test_class = @test_helper.last_log_class
    assert_equal('message', test_class)

    # Test No Prefix
    @window.read_from_standard_input('Testing no prefix' + "\n")
    sleep Repla::Test::TEST_PAUSE_TIME
    test_message = @test_helper.last_log_message
    assert_equal(message, test_message)
    test_class = @test_helper.last_log_class
    assert_equal('message', test_class)

    # Test Blank Spaces
    @window.read_from_standard_input("  \t" + "\n")
    sleep Repla::Test::TEST_PAUSE_TIME
    test_message = @test_helper.last_log_message
    assert_equal(message, test_message)
    test_class = @test_helper.last_log_class
    assert_equal('message', test_class)

    # Test Empty String
    @window.read_from_standard_input('' + "\n")
    sleep Repla::Test::TEST_PAUSE_TIME
    test_message = @test_helper.last_log_message
    assert_equal(message, test_message)
    test_class = @test_helper.last_log_class
    assert_equal('message', test_class)
  end
end
