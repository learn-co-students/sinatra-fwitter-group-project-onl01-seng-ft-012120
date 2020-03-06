class FixTweetTableName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tweets, :contents, :content
  end
end
