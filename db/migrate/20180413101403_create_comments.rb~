class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.belongs_to :gist
      t.belongs_to :user
      t.timestamps
    end
  end
end
