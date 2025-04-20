# frozen_string_literal: true

require_relative 'table'
require_relative 'player'
class Game
  attr_reader :table, :player1, :player2

  def initialize
    @table = Table.new
    @player1 = Player.new(self)
    @player2 = Player.new(self)
  end
end
