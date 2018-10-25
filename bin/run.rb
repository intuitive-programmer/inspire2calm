require_relative '../config/environment'

App.background_music_on
App.reload_screen
create_profile_or_sign_in = App.create_profile_or_sign_in
App.reload_screen

user = User.start(create_profile_or_sign_in)
App.reload_screen

### USER IS READY TO USE THE APP ###
user_selection = User.navigation
App.run(user, user_selection)

App.background_music_off