class AddUserAndIdentity < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :shareholder
      t.integer :shareholding_percent, null: true
      t.timestamps
    end
 
    create_table :identities do |t|
      t.belongs_to :user
      t.string :provider_name
      t.string :uid
      t.timestamps
    end
  end
end
