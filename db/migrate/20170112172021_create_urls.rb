class CreateUrls < ActiveRecord::Migration
  
  def change
    create_table :urls do |t|
      t.belongs_to :user, index: true
      t.string :short_url
      t.string :long_url
      t.integer :click_count, default:0 
      t.timestamps
    end
  end
end
