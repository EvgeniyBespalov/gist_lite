class AddUserToGists < ActiveRecord::Migration
  def change
    add_column :gists, :user, :reference
  end
end
