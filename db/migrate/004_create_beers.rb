class CreateBeers < ActiveRecord::Migration[4.2]
    def change
        create_table :beers do |t|
            t.string :beer_name
            t.string :beer_type
            t.integer :brewery_id
        end
    end
end