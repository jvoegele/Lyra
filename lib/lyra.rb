#require 'bundler/setup'
require 'pathname'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lyra')

module Lyra
end

require 'lyra/helpers/time_helper'
require 'cd_device'
require 'metadata'

require 'commands/print_disc_info_command'