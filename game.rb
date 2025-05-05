# frozen_string_literal: true

require_relative 'table'
require_relative 'player'

class Game
  attr_reader :table, :player_count

  def self.run
    new.run
  end

  def initialize
    @players = []
    @table = Table.new(self, @players)
  end

  def run
    puts '戦争を開始します。'
    setup_players
    deal_cards_players
    @table.battle
    show_result
    puts '戦争を終了します。'
  end

  private

  def setup_players
    print 'プレイヤーの人数を入力してください（2〜5）:'
    @player_count = gets.chomp.to_i

    @player_count.times do |i|
      print "プレイヤー#{i + 1}の名前を入力してください:"
      name = gets.chomp
      @players << Player.new(self, name)
    end
  end

  def deal_cards_players
    @players.each { |player| player.deal_cards(@player_count) }
    puts 'カードが配られました。'
  end

  def show_result
    loser = @players.find { |player| player.deal.empty? }
    puts "#{loser.name}の手札がなくなりました。"

    @players.each do |player|
      puts "#{player.name}の手札は#{player.deal.size}枚です。"
    end

    result_ranking
  end

  def result_ranking
    ranked_players = @players.sort_by { |player| -player.deal.size }
    ranked_players.each.with_index(1) do |player, rank|
      print "#{player.name}が#{rank}位"
      print '、' if rank != @player_count
    end
    puts 'です。'
  end
end
