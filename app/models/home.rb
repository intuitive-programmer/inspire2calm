class Home

    def self.display(user)
        App.reload_screen
        puts "### HOME SWEET HOME ###"
        puts "\n"
        puts "Welcome to a place of inspiration and calm!"
        puts "Here you can enjoy the written word and journeys"
        puts "to the soul, we invite you to explore your inner world"
        puts "through the art of others, which includes:"
        puts "\n"
        puts "  - Posts; that will inspire you."
        puts "  - Meditations; that will calm you."
        puts "\n"
        puts "Let the journey begin!"
        puts "\n"
        App.select_and_run(user)
    end

end