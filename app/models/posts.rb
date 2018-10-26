class Post < ActiveRecord::Base
has_one :category, through: :category_posts

    def self.display(user)
        App.reload_screen
        selected_category = Category.select
        puts "\n"
        #App.select_and_run(user)
        Scrape.get_page_from_category(selected_category)
    end

    def self.show_posts(title_link_hash,description_array,title_array)
        App.reload_screen
        prompt = TTY::Prompt.new
        title_description_hash=Hash[title_array.zip(description_array)]
        selected_post=prompt.select("You can read about the following posts:", title_array)
        article=title_description_hash[selected_post]
        link=title_link_hash[selected_post]
        Post.show_article(article,link)
    end

    def self.show_article(article,link)
      user=user
      App.reload_screen
      puts article
      puts "\n"
      prompt = TTY::Prompt.new
      selected_option=prompt.select("Do you want go to the website and read the whole article?", %w(Yes No))
        if selected_option=="Yes"
            Launchy.open(link)
            App.reload_screen
            App.select_and_run(user)
        else
            App.reload_screen
            App.select_and_run(user)
        end
    end
end