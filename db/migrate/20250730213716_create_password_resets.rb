class CreatePasswordResets < ActiveRecord::Migration[8.0]
  def change
    create_table :password_resets do |t|
      t.string :email
      t.string :code
      t.datetime :sent_at
      t.boolean :verified

      t.timestamps
    end
  end
end
