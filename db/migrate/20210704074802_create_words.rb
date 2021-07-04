class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :japanese
      t.string :english
      t.integer :user_id
      t.integer :difficulty
      t.timestamps
    end
  end
end
