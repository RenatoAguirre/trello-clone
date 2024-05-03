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
# db/seeds.rb

# Clear existing records to prevent duplication issues
Task.delete_all
State.delete_all
Board.delete_all
User.delete_all


# Create users
3.times do |i|
  User.create!(
    name: "user#{i+1}",
    email: "user#{i+1}@example.com"
  )
end

# Create boards with random users
3.times do |i|
  random_user = User.order("RANDOM()").first
  board = random_user.boards.create!(
    name: "Board #{i+1} for #{random_user.name}",
    description: "Description for Board #{i+1} created by #{random_user.name}"
  )
  
  # Create states for each board
  5.times do |j|
    state = board.states.create!(
      name: "State #{j+1} for #{board.name}",
    )
    
    # Create tasks for each state
    5.times do |k|
      state.tasks.create!(
        title: "Task #{k+1} for #{state.name}",
        description: "Description for Task #{k+1} of #{state.name}"
      )
    end
  end
end

puts "Data seeded successfully!"