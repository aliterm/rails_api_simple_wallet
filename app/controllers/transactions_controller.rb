class TransactionsController < ApplicationController
  def index
    transactions = Transaction.all
    render json: transactions
  end

  def credit
    wallet = Wallet.find(params[:target_wallet_id])
    transaction = CreditTransaction.new(target_wallet: wallet, amount: params[:amount], transaction_type: 'credit')

    if transaction.save
      render json: transaction, status: :created
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  def debit
    wallet = Wallet.find(params[:source_wallet_id])
    transaction = DebitTransaction.new(source_wallet: wallet, amount: params[:amount], transaction_type: 'debit')

    if transaction.save
      render json: transaction, status: :created
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  def transfer
    source_wallet = Wallet.find(params[:source_wallet_id])
    target_wallet = Wallet.find(params[:target_wallet_id])
    transaction = Transaction.new(
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: params[:amount],
      transaction_type: 'transfer'
    )

    if transaction.save
      render json: transaction, status: :created
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end
end
