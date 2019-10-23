class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.datetime :registered_at

      t.timestamps
    end
  end
end
