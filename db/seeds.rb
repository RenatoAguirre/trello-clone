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

team1 = Team.create!(name: 'Team One', description: 'This is the first team.')
team2 = Team.create!(name: 'Team Two', description: 'This is the second team.')

# Create users
user1 = User.create!(
  name: 'namee1',
  email: 'user1@example.com',
  password: 'user1@example.com',
  team: team1
)

user2 = User.create!(
  name: 'namee2',
  email: 'user2@example.com',
  password: 'user2@example.com',
  team: team2
)

# Create boards with random users
Board.create!(
  user: user1,
  team: team1,
  name: 'Board One',
  description: 'This is the first board.',
)

Board.create!(
  user: user2,
  team: team2,
  name: 'Board Two',
  description: 'This is the second board.',
)

puts "Data seeded successfully!"