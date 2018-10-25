class App

    ### HEADER ###

    def self.header                                       
        puts " _             _         ___         _       "
        puts "|_|___ ___ ___|_|___ ___|_  |___ ___| |_____ "
        puts "| |   |_ -| . | |  _| -_|  _|  _| .'| |     |"
        puts "|_|_|_|___|  _|_|_| |___|___|___|__,|_|_|_|_|"
        puts "          |_|                                "
        puts "\n"
        puts "### INSPIRATIONAL WORDS AND CALMING SOUNDS ###"
        puts "\n"
        puts "Created by Steven Rico and Dario Spina."
        puts "\n"
        puts "\n"
    end

    ### CREATE PROFILE/SIGN IN AND OUT ###

    def self.create_profile_or_sign_in
        puts "### WELCOME ###"
        puts "\n"
        prompt = TTY::Prompt.new
        prompt.select("What would you like to do?", %w(create_profile sign_in))
    end

    ### APP MUSIC ###

    def self.background_music_on
        @background_music = fork{ exec "afplay public/audio/background_music_i2c.mp3" } 
    end

    def self.background_music_off
        fork{ exec "kill #{@background_music}" }
    end

    ### RUN APPLICATION ###

    def self.select_and_run(user)
        user_selection = User.navigation
        App.run(user, user_selection)
    end

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
            App.run(user, user_selection)
        end
    end
        
    def self.reload_screen
        system("clear")
        App.header
    end

    def self.invalid_input
        puts "Invalid input, have another go!"
    end

    def self.sign_out(user)
        App.reload_screen
        puts "### TIME TO SAY GOODBYE ###"
        puts "\n"
        puts "The journey has come to an end."
        puts "\n"
        puts "It was a pleasure, farewell!"
        puts "\n"
        puts "Credits to Dan, Marju and Wachira."
        puts "\n"
    end
end