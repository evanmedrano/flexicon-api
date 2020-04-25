class AddOauthFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth_provider, :string
    add_column :users, :auth_uid, :string
    add_column :users, :image_url, :string
  end
end
