# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

if Gem::VERSION >= "1.3.6"
	module Rails
		class GemDependency
			def requirement
				r = super
				(r == Gem::Requirement.default) ? nil :r
		end
		end
	end
end

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  config.after_initialize do 
   #    require "ruport" 
   #    require "ruport/acts_as_reportable"
    end
  
 # config.gem "mislav-will_paginate", :lib => "will_paginate", :source => "http://gems.github.com"
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  
  config.gem "declarative_authorization", :source => "http://gemcutter.org"
  config.gem "ancestry"
  
 
  
# config.gem "watu_table_builder", :require => "table_builder", :git => "git://github.com/watu/table_builder.git"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
 # ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
 #   :default => "%Y-%b-%d"
 # )
  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
  #Extends Array and creates a groupby
  class Array
    def in_groups_by
      # Group elements into individual array's by the result of a block
      # Similar to the in_groups_of function.
      # NOTE: assumes array is already ordered/sorted by group !!
      curr=nil.class 
      result=[]
      each do |element|
         group=yield(element) # Get grouping value
         result << [] if curr != group # if not same, start a new array
         curr = group
         result[-1] << element
      end
      result
    end
  end
  
end