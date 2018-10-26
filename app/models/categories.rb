class Category < ActiveRecord::Base
    has_many :category_meditations
    has_many :meditations, through: :category_meditations
    has_many :category_posts
    has_many :posts, through: :category_posts
    
    @@categories_with_count = {
        Mindfulness: 0,
        Spirituality: 0
    }

    # BUG! Doesn't update existing categories.

    def self.update_popularity(selected_category)
        to_be_updated = Category.find_by(name: selected_category)
        Category.update_counters to_be_updated.id, count: 1
        count = Category.where(name: selected_category).count
        selected_category = selected_category.to_sym
        @@categories_with_count[selected_category] = count

        # if @@categories_with_count[selected_category]
        #     binding.pry
        #     @@categories_with_count[selected_category] += 1
        # else
        #     @@categories_with_count[selected_category] = 0
        # end
    end

    def self.categories_by_popularity
        @@categories_with_count
        .sort_by { |category, count| -count }
        .map { |category, count| category }
    end

    def self.display(user)
        App.reload_screen
        puts "### CATEGORIES ###"
        puts "\n"
        category = Category.select
        puts "\n"
        Category.media(user, category)
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

    def self.media(user, category)
        posts = Post.all.select { |p| p.categories.first.name == category }
            .map { |p| p.description }
        puts posts[rand(3)]
        puts "\n"   
        Meditation.get(category)
        .each_with_index do |m, index|
            puts "#{index + 1}. #{m.title}"
        end
        puts "\n"
        App.select_and_run(user)
    end

end
