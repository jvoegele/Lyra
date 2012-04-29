require 'pathname'

CUCUMBER_DIR = Pathname(__FILE__).dirname.parent
PROJECT_DIR = CUCUMBER_DIR.parent
LIB_DIR = PROJECT_DIR + 'lib'

$LOAD_PATH.unshift LIB_DIR.to_s

require 'lyra'
