#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby --disable-gems

require_relative 'bundle/bundler/setup'
require 'repla'

require_relative 'lib/controller'

controller = Repla::Log::Controller.new

ARGF.each do |line|
  controller.parse_input(line)
end
