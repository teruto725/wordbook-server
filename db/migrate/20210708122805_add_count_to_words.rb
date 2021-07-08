class AddCountToWords < ActiveRecord::Migration[6.1]
  def change
    add_column :words, :count, :integer
  end
end
