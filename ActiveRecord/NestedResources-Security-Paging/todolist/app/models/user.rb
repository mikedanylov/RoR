class User < ActiveRecord::Base

  has_secure_password
  
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items

  validates :username, presence: true

  def get_completed_count
    counter = 0
    self.todo_lists.each do |list|
      list.todo_items.each do |item|
        if item.completed
          counter += 1
        end
      end
    end
    return counter
  end

end
