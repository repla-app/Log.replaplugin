#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require_relative 'bundle/bundler/setup'
require 'repla'

require_relative "lib/controller"

controller = Repla::Log::Controller.new

ARGF.each do |line|
  controller.parse_input(line)
end
