# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Clear existing records to avoid duplication issues
# db/seeds.rb

# Clear existing records to avoid foreign key constraint issues
# db/seeds.rb

# Clear existing records to avoid foreign key constraint issues
Task.delete_all
State.delete_all
Board.delete_all
User.delete_all

# Create users
users = User.create([
  { name: 'Alice', email: 'alice@example.com' },
  { name: 'Bob', email: 'bob@example.com' },
  { name: 'Carol', email: 'carol@example.com' }
])

# Define state names outside the loops to ensure consistency
state_names = ['To Do', 'In Progress', 'Review', 'Completed']

# Create boards, states, and tasks for each user
users.each do |user|
  3.times do |i|  # Creating 3 boards for each user
    board = user.boards.create(
      name: "Project #{i + 1}",
      description: "Description for Project #{i + 1}"
    )

    # Create 4 states for each board
    state_names.each do |state_name|
      state = board.states.create(name: state_name)

      # Create at least 5 tasks for each state
      5.times do |j|
        state.tasks.create(
          title: "Task #{j + 1}",
          description: "Description for Task #{j + 1} in state #{state_name}"
        )
      end
    end
  end
end

puts "Data seeded successfully!"
