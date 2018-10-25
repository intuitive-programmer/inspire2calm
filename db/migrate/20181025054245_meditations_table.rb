class MeditationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :meditations do |t|
      t.string :title
      t.string :link
    end
  end
end
