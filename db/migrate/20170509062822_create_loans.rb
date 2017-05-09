class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.string :msisdn
      t.integer :network_id
      t.datetime :date
      t.integer :product_id
      t.decimal :amount, :precision => 10, :scale => 2
      t.integer :loan_file_id

      t.timestamps
    end
    add_index :loans, :network_id
    add_index :loans, :product_id
    add_index :loans, :loan_file_id
  end
end
