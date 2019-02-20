class CreatePannels < ActiveRecord::Migration[5.2]
  def change
    create_table :pannels do |t|
      t.string :PID, null: false
      t.string :SID, null: false
      t.date :date, null: false
      t.float :reading
      t.integer :amount
      t.integer :advisement
      t.float :acceptance
      t.integer :accepted
      t.timestamps
    end
  end
end
