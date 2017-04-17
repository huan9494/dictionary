class CreateTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :translations do |t|
      t.string :keyword
      t.string :discription
      t.string :pictures
      t.integer :query_number

      t.timestamps
    end
  end
end
