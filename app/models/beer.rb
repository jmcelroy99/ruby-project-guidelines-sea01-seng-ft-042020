class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :reviews
    has_many :users, through: :reviews

end