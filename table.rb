# frozen_string_literal: true

require_relative 'card'
require_relative 'game'
require_relative 'player'
class Table
  attr_reader :shuffled_deck

  def initialize(game, players)
    card = Card.new
    @shuffled_deck = card.deck.shuffle
    @game = game
    @players = players
    @layout = []
    @suits = []
    @ranks = []
  end

  def draw_battle_layout
    battle_layout = []
    @players.each do |player|
      battle_layout << player.deal.shift
    end
    battle_layout
  end

  def draw_suits_ranks(battle_layout)
    suits = []
    ranks = []
    battle_layout.map do |suit, rank|
      suits << suit
      ranks << rank
    end
    [suits, ranks]
  end

  def puts_battle_layout(suits, ranks)
    @game.player_count.times do |i|
      puts "#{@players[i].name}のカードは#{suits[i]}の#{ranks[i]}です。"
    end
  end

  def battle_result(winner_index)
    puts "#{@players[winner_index].name}が勝ちました。#{@players[winner_index].name}はカードを#{@layout.size}枚もらいました。"
    @players[winner_index].add_deal(*@layout)
    @layout = []
  end

  def battle
    loop do
      break if @players.any? { |player| player.deal.empty? }

      battle_layout = draw_battle_layout
      suits, ranks = draw_suits_ranks(battle_layout)
      @layout.concat(battle_layout)
      puts '戦争！'
      puts_battle_layout(suits, ranks)
      ranks_strength = ranks.map { |rank| Card::RANKS.index(rank) }

      if ranks.count('A') > 1 && suits[ranks.index('A')] == 'スペード'
        battle_result(ranks.index('A'))
        next
      end

      if ranks_strength.count(ranks_strength.min) > 1
        puts '引き分けです。'
        next
      end
      battle_result(ranks_strength.index(ranks_strength.min))
    end
  end
end
