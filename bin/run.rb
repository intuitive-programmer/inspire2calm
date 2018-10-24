require_relative '../config/environment'

App.header
create_profile_or_sign_in = App.create_profile_or_sign_in
User.start(create_profile_or_sign_in)

