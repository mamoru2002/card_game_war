# frozen_string_literal: true

def initialize(game)
  @game = game
  @deal = []
end

class Player
  def deal
    (0..25).each do |_i|
      @deal << @game.table.shuffled_deck.shift
    end
    @deal
  end
end
