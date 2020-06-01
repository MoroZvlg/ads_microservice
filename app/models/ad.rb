class Ad < ApplicationRecord
  many_to_one :user
end