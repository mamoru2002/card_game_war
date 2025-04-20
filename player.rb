# frozen_string_literal: true

class Player
  attr_reader :deal

  def initialize(game)
    @game = game
    @deal = []
  end

  def deal_cards
    (0..25).each do |_i|
      @deal << @game.table.shuffled_deck.shift
    end
  end

  def add_deal(*cards)
    @deal.concat(cards)
  end
end
