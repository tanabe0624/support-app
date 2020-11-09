class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true
      t.string :text, null: false
      t.timestamps
    end
  end
end
