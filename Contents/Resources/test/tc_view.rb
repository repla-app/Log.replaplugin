#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative '../bundle/bundler/setup'

require_relative 'lib/test_helper'

require 'repla/test'
require Repla::Test::REPLA_FILE

require_relative '../lib/view'

# Test view
class TestView < Minitest::Test
  def setup
    @view = Repla::Log::View.new
    @test_helper = Repla::Log::Test::TestHelper.new(@view)
  end

  def teardown
    @view.close
  end

  def test_javascript
    # Test Error
    message = 'Testing log error'
    @view.log_error(message)
    test_message = @test_helper.last_log_message
    assert_equal(message, test_message, 'The messages should match')
    test_class = @test_helper.last_log_class
    assert_equal('error', test_class, 'The classes should match')

    # Test Message
    message = 'Testing log message'
    @view.log_message(message)
    test_message = @test_helper.last_log_message
    assert_equal(message, test_message, 'The messages should match')
    test_class = @test_helper.last_log_class
    assert_equal('message', test_class, 'The classes should match')
  end
end
