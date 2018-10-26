class CreateTablePostsAndCategoryPost < ActiveRecord::Migration[5.2]
  def change
    create_table  :posts do |t|
    t.string      :title
    t.string      :description
    t.string      :link
    end

    create_table  :category_posts do |t|
    t.integer     :category_id
    t.integer     :post_id
    end
  end
end
