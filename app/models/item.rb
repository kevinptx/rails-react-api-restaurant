class Item < ApplicationRecord
  belongs_to :menu, optional: true
end
