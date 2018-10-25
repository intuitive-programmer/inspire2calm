class Post < ActiveRecord::Base

    def self.display(user)
        App.reload_screen
        selected_category = Category.select
        puts "\n"
        App.select_and_run(user)
    end

end