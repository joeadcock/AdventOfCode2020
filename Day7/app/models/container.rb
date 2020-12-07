class Container < ApplicationRecord
  validates :color, uniqueness: true
end
