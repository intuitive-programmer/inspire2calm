class Scrape

  def self.get_page_from_category(category)
      webpage=Nokogiri::HTML(open("https://medium.com/tag/#{category}"))
      Scrape.get_title_array(webpage,category)
  end

  def self.get_title_array(webpage,category)
      title_array=webpage.css('div.section-content h3').map {|x| x.text}
      title_array=title_array[0...3]
      @category=category
      @posts = Scrape.select_posts_to_update(category)
      Scrape.update_database("title", title_array)
      Scrape.website_array(webpage,title_array)
  end

  def self.select_posts_to_update(category)
    Post.all.find { |p| p.categories.first.name == category }
  end

    def self.update_database(to_update , array)
        array.each_with_index do |value, index|
                post_to_update = Post.find(@posts.id+index)
                if post_to_update.categories.first.name == @category
                    post_to_update.update("#{to_update}": value)
                end
        end
    end

  def self.website_array(webpage,title_array)
      website_array=webpage.css('div.js-tagStream a').map {|x| x.attribute('href').value}.map{|x| x.split('?')}.map{|x| x[0]}.uniq.select {|x| x.size>50 }
      website_array=website_array[0...3]
      Scrape.update_database("link", website_array)
      Scrape.title_link_hash(title_array,website_array)

  end

  def self.title_link_hash(title_array,website_array)
      title_link_hash=Hash[title_array.zip(website_array)]
      Scrape.description_array(title_link_hash,title_array)
  end

  def self.description_array(title_link_hash,title_array)
      description_array=title_link_hash.map{|x,y| "#{x} - #{Nokogiri::HTML(open(y)).css('div.section-inner').text[x.length...500]} ... Continues on the website"}
      Scrape.update_database("description", description_array)
      Post.show_posts(title_link_hash,description_array,title_array)
  end

end
