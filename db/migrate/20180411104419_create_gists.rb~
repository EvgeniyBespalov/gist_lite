class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :file_name
      t.text :text
      t.belongs_to :user
      t.timestamps
    end
  end
end
