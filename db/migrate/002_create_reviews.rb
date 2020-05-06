class CreateReviews < ActiveRecord::Migration[4.2]
    def change
        create_table :reviews do |t|
            t.integer :beer_id
            t.integer :user_id
            t.integer :rating
            t.string :review
        end
    end
end