# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_magmawiki_session',
  :secret      => 'd3519dd4adce79d86819a94302da33f4a901e335afb833891a7971f3ed264d520b27df5e2ff5e0c80c1215bb086b636e8259056d346bc9aaf9edc0c3d707f4ad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
