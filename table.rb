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

      print @players[0].deal.size
      puts @players[0].name
      print @players[1].deal.size
      puts @players[1].name
      print @players[2].deal.size
      puts @players[2].name
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
      # puts "ランク配列: #{rank_layout.inspect}"
      # puts "バトル場札: #{battle_layout.inspect}"
      # puts "場札: #{@layout.inspect}"
      rank_layout = rank_layout.map { |rank| Card::RANKS.index(rank) }

      if rank_layout.uniq.length != rank_layout.length
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
