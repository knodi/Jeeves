# Load the Rails application.
require_relative 'application'

#APP_VERSION = `git describe --always`.freeze unless defined? APP_VERSION
APP_VERSION = Rails.configuration.root.to_s.split('/').last

# Initialize the Rails application.
Rails.application.initialize!
