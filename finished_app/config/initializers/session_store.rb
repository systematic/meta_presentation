# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_start_app_session',
  :secret      => 'c7ded53c761922ce50dd10c2d5c9797094d4964ebd94bcd564897a4f0d8be71dd80faa957dc8fb3053d12d47088b89603c310d744632beaa1a074a95a47db156'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
