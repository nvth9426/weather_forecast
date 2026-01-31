class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
