# frozen_string_literal: true

class Player
  attr_reader :deal, :name

  def initialize(game, name)
    @game = game
    @name = name
    @deal = []
  end

  def deal_cards(player_count)
    (52 / player_count).times do |_i|
      @deal << @game.table.shuffled_deck.shift
    end
  end

  def add_deal(*cards)
    @deal.concat(cards)
    @deal.shuffle!
  end
end
