# frozen_string_literal: true

require_relative 'table'
require_relative 'player'
class Game
  attr_reader :table, :player1, :player2

  def initialize
    @player1 = Player.new(self)
    @player2 = Player.new(self)
    @table = Table.new(self, @player1, @player2)

    puts '戦争を開始します。'

    @player1.deal_cards
    @player2.deal_cards
    puts 'カードが配られました。'

    @table.battle
  end
end
