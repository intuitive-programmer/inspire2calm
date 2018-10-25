class User < ActiveRecord::Base

    def self.start(create_profile_or_sign_in)
        case create_profile_or_sign_in
        when "create_profile"
            User.create_profile
        when "sign_in"
            User.sign_in
        else
            App.invalid_input
        end
    end

    def self.create_profile
        puts "### CREATE A PROFILE ###"
        puts "\n"
        puts "Please enter a username:"
        puts "\n"
        print ">> "
        username_input = gets.chomp
        user = User.create(username: username_input)
        puts "Thanks #{username_input}, your profile is all set up. Enjoy the app!"
        return user
    end

    def self.sign_in
        puts "### SIGN IN ###"
        puts "\n"
        puts "Please enter your username to sign in:"
        puts "\n"
        print ">> "
        username_input = gets.chomp
        User.validate_user_sign_in(username_input)
    end

    def self.validate_user_sign_in(username_input)
        user = User.find_by(username: username_input)
        if user == nil
            App.reload_screen
            puts "### ATTENTION ###"
            puts "\n"
            puts "Hmmm! We couldn't find you in our system."
            puts "\n"
            create_profile_or_sign_in = App.create_profile_or_sign_in
            User.start(create_profile_or_sign_in)
        elsif user.username == username_input
            return user
        end
    end
    
    def self.navigation
        prompt = TTY::Prompt.new
        prompt.select("Where would you like to go?", %w(home categories posts meditations sign_out))
    end

end