# frozen_string_literal: true

require_relative 'card'
require_relative 'game'
require_relative 'player'
class Table
  attr_reader :shuffled_deck

  def initialize(game, player1, player2)
    card = Card.new
    @shuffled_deck = card.deck.shuffle
    @game = game
    @player1 = player1
    @player2 = player2
  end

  def battle
    loop do
      puts '戦争！'

      player1_card = @player1.deal.shift
      player2_card = @player2.deal.shift

      suit1, rank1 = player1_card
      suit2, rank2 = player2_card

      puts "プレイヤー1のカードは#{suit1}の#{rank1}です。"
      puts "プレイヤー2のカードは#{suit2}の#{rank2}です。"

      if Card::RANKS.index(rank1) < Card::RANKS.index(rank2)
        puts 'プレイヤー1が勝ちました。'
        break
      elsif Card::RANKS.index(rank1) > Card::RANKS.index(rank2)
        puts 'プレイヤー2が勝ちました。'
        break
      else
        puts '引き分けです。'
        next
      end
    end
  end
end
