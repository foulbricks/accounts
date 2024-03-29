class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password
      t.string :salt
      t.string :pwcode
      t.string :activation_code

      t.timestamps
    end
  end
end
