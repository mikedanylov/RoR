# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

num_users = 4
cur_profile_id = 0
cur_list_id = 0
cur_item_id = 0

user_objects = []
user_objects[0] = User.create! username: 'Fiorina', password_digest: 'fiorina1954'
user_objects[1] = User.create! username: 'Trump', password_digest: 'trump1946'
user_objects[2] = User.create! username: 'Carson', password_digest: 'carson1951'
user_objects[3] = User.create! username: 'Clinton', password_digest: 'clinton1947'

profiles = [
  {gender: 'female', first_name: 'Carly', last_name: 'Fiorina', birth_year: 1954, user_id: 1},
  {gender: 'male', first_name: 'Donald', last_name: 'Trump', birth_year: 1946, user_id: 2},
  {gender: 'male', first_name: 'Ben', last_name: 'Carson', birth_year: 1951, user_id: 3},
  {gender: 'female', first_name: 'Hillary', last_name: 'Clinton', birth_year: 1947, user_id: 3}
]

profiles.each do |prof|
  Profile.create! prof
end

lists = [
  {list_name: 'shopping', list_due_date: Date.today + 1.year},
  {list_name: 'wars', list_due_date: Date.today + 1.year},
  {list_name: 'songs', list_due_date: Date.today + 1.year},
  {list_name: 'promises', list_due_date: Date.today + 1.year}
]

items = [
  {title: 'cheese', due_date: Date.today + 1.year, description: 'only gouda', completed: true},
  {title: 'milk', due_date: Date.today + 1.year, description: '1.5%', completed: true,},
  {title: 'bread', due_date: Date.today + 1.year, description: 'rye', completed: true},
  {title: 'bananas', due_date: Date.today + 1.year, description: '4-5', completed: true},
  {title: 'beef', due_date: Date.today + 1.year, description: 'for burgers', completed: true},

  {title: 'star', due_date: Date.today + 1.year, description: 'in space', completed: false,},
  {title: 'desert', due_date: Date.today + 1.year, description: 'lots of sand', completed: false},
  {title: 'step', due_date: Date.today + 1.year, description: 'boring', completed: false},
  {title: 'swamp', due_date: Date.today + 1.year, description: 'dirty', completed: false},
  {title: 'sea', due_date: Date.today + 1.year, description: 'seasick', completed: false},

  {title: 'New York', due_date: Date.today + 1.year, description: 'by Sinatra', completed: true},
  {title: 'Floods', due_date: Date.today + 1.year, description: 'by Fightstar', completed: false},
  {title: 'Just', due_date: Date.today + 1.year, description: 'by Radiohead', completed: false},
  {title: 'Bluebird', due_date: Date.today + 1.year, description: 'by Beatles', completed: true},
  {title: 'Doughters', due_date: Date.today + 1.year, description: 'by John Mayers', completed: false},

  {title: 'salaries', due_date: Date.today + 1.year, description: 'delayed', completed: false},
  {title: 'healthcare', due_date: Date.today + 1.year, description: 'delayed', completed: false},
  {title: 'education', due_date: Date.today + 1.year, description: 'delayed', completed: false},
  {title: 'public transport', due_date: Date.today + 1.year, description: 'delayed', completed: false},
  {title: 'recreation', due_date: Date.today + 1.year, description: 'delayed', completed: false},
]

user_objects.each do |user|
  current_list = user.todo_lists.create! lists[cur_list_id]
  for i in cur_item_id..(cur_item_id + 4)
    current_item = current_list.todo_items.create! items[cur_item_id]
    cur_item_id += 1
  end
  cur_list_id += 1
end
