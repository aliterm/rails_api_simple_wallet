class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  after_create :update_wallet_balances

  private

  def validate_wallets
    if self.class.name == 'CreditTransaction'
      errors.add(:source_wallet, 'must be nil for credit transactions') if source_wallet.present?
      errors.add(:target_wallet, 'is required for credit transactions') if target_wallet.blank?
    elsif self.class.name == 'DebitTransaction'
      errors.add(:target_wallet, 'must be nil for debit transactions') if target_wallet.present?
      errors.add(:source_wallet, 'is required for debit transactions') if source_wallet.blank?
    end
  end

  def update_wallet_balances
    Wallet.transaction do
      source_wallet&.update_balance!
      target_wallet&.update_balance!
    end
  end
end

class CreditTransaction < Transaction
  def initialize(attributes = {})
    super(attributes)
  end
end

class DebitTransaction < Transaction
def initialize(attributes = {})
    super(attributes)
  end
end
