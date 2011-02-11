# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ICMS_session',
  :secret      => '9083c06747aff20c7456dfd2fa601a1ffc19cc4809bc7bcad04f5b3b893e120000a5f4366c8de1dbc41c2de1ac8dc686c2a5f9826fe4f79ddfebc01f554f78bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
