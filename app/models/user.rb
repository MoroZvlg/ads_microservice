class User < ApplicationRecord
  one_to_many :ads
end