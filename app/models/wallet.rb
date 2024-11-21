class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :incoming_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id
  has_many :outgoing_transactions, class_name: 'Transaction', foreign_key: :source_wallet_id

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def update_balance!
    self.balance = Transaction.where(target_wallet: self).sum(:amount) - Transaction.where(source_wallet: self).sum(:amount)
    save!
  end
end
