class CreateServerLoadHistory < ActiveRecord::Migration
  def change
    create_table :server_load_histories do |t|
      t.references :server, index: true, foreign_key: true
      t.decimal :cpu
      t.decimal :memory
      t.decimal :disk

      t.timestamps null: false
    end
  end
end
