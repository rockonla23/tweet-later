class CreateTwitterUsers < ActiveRecord::Migration
  def change
  	create_table :twitter_users do |t|
      t.string :twitter_username
      t.string :oauth_token
      t.string :oauth_token_secret

  		t.timestamps
  	end
  end
end