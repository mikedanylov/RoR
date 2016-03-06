class TodoItem < ActiveRecord::Base

  def self.count_completed
    count = 0
    TodoItem.all.each do |item|
      count += 1 if item.completed?
    end
    return count
  end
end
