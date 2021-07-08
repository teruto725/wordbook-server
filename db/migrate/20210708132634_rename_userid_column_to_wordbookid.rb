class RenameUseridColumnToWordbookid < ActiveRecord::Migration[6.1]
  def change
    rename_column :words, :user_id, :wordbook_id
  end
end
