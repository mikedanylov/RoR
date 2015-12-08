class User < ActiveRecord::Base
  has_one :profile
  has_many :todo_lists
  has_many :todo_items, through: :todo_lists, source: :todo_items
end
