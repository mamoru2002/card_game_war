# frozen_string_literal: true

require_relative 'table'
require_relative 'player'
class Game
  attr_reader :table, :player_count

  def initialize
    @players = []
    @table = Table.new(self, @players)

    puts '戦争を開始します。'
    setup_players

    deal_cards_players

    @table.battle
    show_result

    puts '戦争を終了します。'
  end
end

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
  lose_index = (@players.map { |player| player.deal.size }).index(&:zero?)
  puts "#{@players[lose_index].name}の手札がなくなりました。"
  @players.each do |player|
    print "#{player.name}の手札は#{player.deal.size}枚です。"
  end
  result_ranking
end

def result_ranking
  @players = @players.sort_by { |player| player.deal.size }.reverse
  @players.each.with_index do |player, i|
    print "#{player.name}が#{i + 1}位"
    print '、' if i != @player_count - 1
  end
  puts 'です。'
end
