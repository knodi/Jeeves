# Load the Rails application.
require_relative 'application'

# APP_VERSION = `git describe --always`.freeze unless defined? APP_VERSION
APP_VERSION = if Rails.env.development?
                'development'
              else
                Rails.configuration.root.to_s.split('/').last
              end

# Initialize the Rails application.
Rails.application.initialize!
