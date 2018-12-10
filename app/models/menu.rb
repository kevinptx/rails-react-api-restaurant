class Menu < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_uniqueness_of :name
end
