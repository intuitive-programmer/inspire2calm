class Meditation < ActiveRecord::Base

    def self.display(user)
        App.reload_screen
        puts "### MEDITATIONS ###"
        puts "\n"
        selected_category = Category.select
        puts "\n"
        Meditation.run(user, selected_category)
        App.select_and_run(user)
    end

    def self.run(user, selected_category)
        selected_meditation = Meditation.select(selected_category)
        
        Meditation.play(selected_meditation)
    end
    
    def self.select(selected_category)
        prompt = TTY::Prompt.new
        choices = []
        Meditation.get(selected_category)
        .each_with_index do |m, index|
            choices << "#{index + 1}. #{m.title}"
        end
        selected_meditation = prompt.select("What meditation would you like to listen to?", choices)
    end
    
    def self.get(selected_category)
        meditation_ids = Meditation.get_ids(selected_category)            
        @meditation = Meditation.where(id: meditation_ids)
        binding.pry
    end

    def self.get_ids(selected_category)
        category_id = Category.get_id(selected_category)
        CategoryMeditation.where(category_id: category_id).ids
    end

    def self.play(selected_meditation)
        App.reload_screen
        puts "### MEDITATION: #{selected_meditation} ###"
        puts "\n"
        puts "Your meditation is playing!!!"
        puts "\n"
        puts "When your finished relaxing..."
        puts "\n"
    end
end