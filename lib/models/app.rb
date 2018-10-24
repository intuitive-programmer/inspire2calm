class App

    ### HEADER ###
    def self.header
        puts "This is inspire2calm!"
    end

    ### CREATE PROFILE/SIGN IN AND OUT ###
    def self.create_profile_or_sign_in
        prompt = TTY::Prompt.new
        prompt.select("What would you like to do?", %w(create_profile sign_in))
    end

    ### RUN APPLICATION ###
    def self.run
        user_select = User.navigation
        case user_select
        when "home"
            Home.display
        when "categories"
            Category.display
        when "posts"
            Post.display
        when "meditations"
            Meditation.display
        when "sign_out"
            App.sign_out
        else
            App.invalid_input
        end
    end

    def self.reload_screen
        system("clear")
        App.header
    end

    def self.invalid_input

    end

    def self.sign_out

    end
end