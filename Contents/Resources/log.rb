#!/usr/bin/env ruby --disable-gems

require_relative 'bundle/bundler/setup'
require 'repla'

require_relative 'lib/controller'

controller = Repla::Log::Controller.new

ARGF.each do |line|
  controller.parse_input(line)
end
