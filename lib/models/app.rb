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
    def self.run(user, user_selection)
        case user_selection
        when "home"
            Home.display(user)
        when "categories"
            Category.display(user)
        when "posts"
            Post.display(user)
        when "meditations"
            Meditation.display(user)
        when "sign_out"
            App.sign_out(user)
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