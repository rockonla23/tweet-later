class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :twitter_user_id, index: true
      t.string :text
      t.integer :job_id
      t.timestamps
    end
  end
end