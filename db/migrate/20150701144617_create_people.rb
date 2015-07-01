class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, limit: 50, null: false
      t.string :email, limit: 100
      t.string :password, limit: 50
      t.date :born_at
      t.boolean :admin
      t.index :email, unique: true

      t.timestamps null: false
    end
  end
end
