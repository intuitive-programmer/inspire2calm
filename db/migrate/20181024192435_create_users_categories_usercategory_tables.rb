class CreateUsersCategoriesUsercategoryTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
    end

    create_table :categories do |t|
      t.string :name
      t.integer :count
    end

    create_table :user_category do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end
end
