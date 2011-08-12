source :rubygems

gem 'rails', '3.0.9'

gem 'devise', '1.1.7'       # Authentication
gem 'nifty-generators'      # wat?
gem "builder", "~> 2.1.2"   # XML/HTML generator

# Markup engines
gem 'wikicloth', :git => "https://github.com/epitron/wikicloth.git"
gem "rdiscount"
gem "RedCloth"


## DEV ENVIRONMENT
group :development do
  gem 'sqlite3'
  gem 'ZenTest', '~> 4.5.0'
end

## TEST ENVIRONMENT
group :test, :cucumber do
  gem 'sqlite3'
  
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'shoulda'
  
  gem 'factory_girl_rails'
  
  gem 'database_cleaner'
  
  #gem 'webrat'
  #gem 'mocha'
end
