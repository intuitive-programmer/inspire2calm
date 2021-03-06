class Category < ActiveRecord::Base

    @@categories_with_count = {
        Mindfulness: 0,
        Shamanic: 0
    }

    # BUG! Doesn't update existing categories.

    def self.update_popularity(selected_category)
        to_be_updated = Category.find_by(name: selected_category)
        Category.update_counters to_be_updated.id, count: 1

        @@categories_with_count[selected_category] ||= to_be_updated.count
    end

    def self.categories_by_popularity
        @@categories_with_count
        .sort_by { |category, count| count }
        .map { |category, count| category }
    end

    def self.display(user)
        App.reload_screen
        puts "### CATEGORIES ###"
        puts "\n"
        Category.select
        puts "\n"
        # Category.media?
        App.select_and_run(user)
    end

    def self.select
        prompt = TTY::Prompt.new
        choices = []
        Category.categories_by_popularity
            .each_with_index do |category, index|
                choices << "#{index + 1}. #{category}"
            end
        selected_category = prompt.select("What category would you like to explore?", choices)
        selected_category = selected_category.split.last
        Category.update_popularity(selected_category)
        return selected_category
    end

    def self.get_id(selected_category)
        Category.find_by(name: selected_category).id
    end

    def self.media
        # Post.title
        # Post.blurb
        # Post.read_more
        # Meditation.display
        # Meditation.select
    end

end
