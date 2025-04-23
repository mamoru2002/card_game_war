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

  def battle
    loop do
      break if battle_finish?

      play_one_round
    end
  end

  def battle_finish?
    return false unless @players.any? { |player| player.deal.empty? }

    true
  end

  def play_one_round
    puts '戦争！'
    battle_layout = collect_battle_layout

    @layout.concat(battle_layout)
    return if handle_joker(battle_layout)

    suits, ranks = draw_suits_ranks(battle_layout)
    puts_battle_layout(suits, ranks)
    ranks_strength = ranks.map { |rank| Card::RANKS.index(rank) }
    return if handle_a_spade(ranks, suits) || handle_draw(ranks_strength)

    battle_result(ranks_strength.index(ranks_strength.min))
  end

  def collect_battle_layout
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
    puts "#{@players[winner_index].name}が勝ちました。"
    print "#{@players[winner_index].name}はカードを#{@layout.size}枚もらいました。"
    @players[winner_index].add_deal(*@layout)
    @layout = []
  end

  def handle_joker(battle_layout)
    return false unless battle_layout.include?('ジョーカー')

    print "#{@players[battle_layout.index('ジョーカー')].name}がジョーカーを出しました。"
    battle_result(battle_layout.index('ジョーカー'))
    true
  end

  def handle_a_spade(ranks, suits)
    return false unless ranks.count('A') > 1 && suits[ranks.index('A')] == 'スペード'

    battle_result(ranks.index('A'))
    true
  end

  def handle_draw(ranks_strength)
    return false unless ranks_strength.count(ranks_strength.min) > 1

    puts '引き分けです。'
    true
  end
end
