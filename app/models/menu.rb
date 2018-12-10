class Menu < ApplicationRecord
  has_many :items
  validates_uniqueness_of :name
end
