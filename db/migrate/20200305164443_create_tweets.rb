class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string  :contents
      t.integer :user_id
    end
  end
end
