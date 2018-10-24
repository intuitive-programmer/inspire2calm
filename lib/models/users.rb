class User < ActiveRecord::Base

    def self.start(create_profile_or_sign_in)
        case create_profile_or_sign_in
        when "create_profile"
            create_profile
        when "sign_in"
            sign_in
        else
            App.invalid_input
        end
    end

    def create_profile
        puts "Please enter a username:"
        username_input = gets.chomp
        user = User.create(username: username_input)
        puts "Thanks #{username_input}, your profile is all set up. Enjoy the app!"
        return user
    end

    def sign_in
        puts "Please enter your username to sign in:"
        username_input = gets.chomp
        validate_user_sign_in(username_input)
    end

    def validate_user_sign_in(username_input)
        user = User.find_by(username: username_input)
        if user.username == username_input
            puts "Thank you #{user.username}, your profile is ready to use."
            return user
        else
            puts "Hmmm! We couldn't find you in our system."
            puts # newline
            create_profile_or_sign_in = App.create_profile_or_sign_in
            User.start(create_profile_or_sign_in)
        end
    end
    
    def self.navigation
        prompt = TTY::Prompt.new
        prompt.select("Where would you like to go?", %w(home categories posts meditations sign_out))
    end

end