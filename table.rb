# frozen_string_literal: true

require 'pp'
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
      break if @players.any? { |player| player.deal.empty? }

      @suits = []
      @ranks = []
      battle_layout = []

      @players.each do |player|
        battle_layout << player.deal.shift
      end

      @layout.concat(battle_layout)

      battle_layout.map do |suit, rank|
        @suits << suit
        @ranks << rank
      end

      puts '戦争！'

      @game.player_count.times do |i|
        puts "#{@players[i].name}のカードは#{@suits[i]}の#{@ranks[i]}です。"
      end

      rank_layout = battle_layout.map { |rank| rank[1] }

      rank_layout = rank_layout.map { |rank| Card::RANKS.index(rank) }

      min_rank = rank_layout.min

      if rank_layout.count(min_rank) > 1
        puts '引き分けです。'
        next
      end

      winner_index = rank_layout.index(rank_layout.min)

      puts "#{@players[winner_index].name}が勝ちました。#{@players[winner_index].name}はカードを#{@layout.size}枚もらいました。"
      @players[winner_index].add_deal(*@layout)
      @layout = []
    end
  end
end
