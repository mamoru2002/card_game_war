# frozen_string_literal: true

require_relative 'card'
class Table
  attr_reader :shuffled_deck

  def initialize
    card = Card.new
    @shuffled_deck = card.deck.shuffle
  end
end
