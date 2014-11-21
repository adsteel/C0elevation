# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
CoElv2::Application.initialize!
Rails.logger = Logger.new(STDOUT)
Rails.logger.level = 0