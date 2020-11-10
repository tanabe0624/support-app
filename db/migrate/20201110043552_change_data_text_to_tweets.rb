class ChangeDataTextToTweets < ActiveRecord::Migration[6.0]
  def up
    change_column :tweets, :text, :text
  end
end
