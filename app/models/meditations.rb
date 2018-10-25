class Meditation < ActiveRecord::Base

    def self.display(user)
        App.reload_screen
        puts "### MEDITATIONS ###"
        puts "\n"
        selected_category = Category.select
        puts "\n"
        Meditation.run(user, selected_category)
        App.reload_screen
        puts "### WE HOPE YOU ENJOYED YOUR MEDITATION ###"
        puts "\n"
        puts "\n"
        App.select_and_run(user)
    end

    def self.run(user, selected_category)
        selected_meditation = Meditation.select(selected_category)

        Meditation.play(selected_meditation)
        Meditation.stop
    end
    
    def self.select(selected_category)
        prompt = TTY::Prompt.new
        choices = []
        Meditation.get(selected_category)
        .each_with_index do |m, index|
            choices << "#{index + 1}. #{m.title}"
        end
        prompt.select("What meditation would you like to listen to?", choices)
    end
    
    def self.get(selected_category)
        meditation_ids = Meditation.get_ids(selected_category)            
        Meditation.where(id: meditation_ids)
    end

    def self.get_ids(selected_category)
        category_id = Category.get_id(selected_category)
        CategoryMeditation.where(category_id: category_id).ids
    end

    def self.play(selected_meditation)
        App.reload_screen
        App.background_music_off
        puts "### MEDITATION: #{selected_meditation} ###"
        puts "\n"
        puts "Your meditation is playing!!!"
        puts "\n"
        App.delay(2)
        meditation_to_play = Meditation.find_by(title: selected_meditation[3..-1])
        @meditation = fork{ exec "afplay #{meditation_to_play.link}" }
    end

    def self.stop
        prompt = TTY::Prompt.new
        user_stop = prompt.select("When you're ready to finish the meditation session press 'enter'", %w(all_done))
        if user_stop == "all_done"
            puts "\n"
            puts "Meditation is coming to an end..."
            App.delay(1.5)
            fork{ exec "kill #{@meditation}" }
        end
        App.background_music_on
    end
end