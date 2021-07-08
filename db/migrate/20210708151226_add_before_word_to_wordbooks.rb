class AddBeforeWordToWordbooks < ActiveRecord::Migration[6.1]
  def change
    add_column :wordbooks, :before_word_id, :integer
  end
end
