class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :password
      t.date :born_at
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
