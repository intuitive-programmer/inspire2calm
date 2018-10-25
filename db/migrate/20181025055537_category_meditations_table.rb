class CategoryMeditationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :category_meditations do |t|
      t.integer :category_id
      t.integer :meditation_id
    end
  end
end
