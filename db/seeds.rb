# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data
User.destroy_all
Wallet.destroy_all
Transaction.destroy_all

# Create Users
puts 'Seeding Users...'
users = []
3.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Create Wallets for Users
puts 'Seeding Wallets...'
user_wallets = users.map do |user|
  Wallet.create!(
    walletable: user,
    balance: rand(10000..50000) # Random initial balance
  )
end

# Create Transactions
puts 'Seeding Transactions...'
5.times do
  source_wallet = user_wallets.sample
  target_wallet = (user_wallets - [source_wallet]).sample
  amount = rand(50..500)

  # Randomly create a credit, debit, or transfer transaction
  case rand(3)
  when 0
    # Credit
    CreditTransaction.create!(
      target_wallet: target_wallet,
      amount: amount
    )
  when 1
    # Debit
    DebitTransaction.create!(
      source_wallet: source_wallet,
      amount: amount
    )
  when 2
    # Transfer
    Transaction.create!(
      transaction_type: 'transfer',
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: amount
    )
  end
end

puts 'Seeding Complete!'
