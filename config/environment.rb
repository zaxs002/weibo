# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Weibo::Application.initialize!
config.gem "mongo_mapper",:source=>"http://gemcutter.org"
config.frameworks -= [:active_record]