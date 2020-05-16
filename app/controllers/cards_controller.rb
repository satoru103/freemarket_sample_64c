class CardsController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(card) if card.exists?
  end

  def pay
    Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: 'show'
      else
        redirect_to pay_cards_path
      end
    end
  end

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(card) if card.exists?
  end

  def pay
    Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(@card)
      else
        redirect_to pay_cards_path(@card)
      end
    end
  end

  def delete
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
      redirect_to new_card_path
    end
  end

  def show
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to new_card_path(@user)
    else
      Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

end
