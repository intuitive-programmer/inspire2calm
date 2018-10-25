class Scrape

  def self.get_page_from_category(category)
    if category=="Shamanic"
      category='spirituality'
    end
      webpage=Nokogiri::HTML(open("https://medium.com/tag/#{category}"))
      Scrape.get_title_array(webpage)
  end

  def self.get_title_array(webpage)
      title_array=webpage.css('div.section-content h3').map {|x| x.text}
      title_array=title_array[0...3]
      Scrape.website_array(webpage,title_array)
  end

  def self.website_array(webpage,title_array)
      website_array=webpage.css('div.js-tagStream a').map {|x| x.attribute('href').value}.map{|x| x.split('?')}.map{|x| x[0]}.uniq.select {|x| x.size>50 }
      website_array=website_array[0...3]
      Scrape.title_link_hash(title_array,website_array)
  end

  def self.title_link_hash(title_array,website_array)
      title_link_hash=Hash[title_array.zip(website_array)]
      Scrape.description_array(title_link_hash,title_array)
  end

  def self.description_array(title_link_hash,title_array)
      description_array=title_link_hash.map{|x,y| "#{x} - #{Nokogiri::HTML(open(y)).css('div.section-inner').text[x.length...500]} ... Continues on the website"}
      Post.show_posts(title_link_hash,description_array,title_array)
  end

end
