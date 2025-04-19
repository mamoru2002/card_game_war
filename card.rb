# frozen_string_literal: true

class Card
  SUITS = %w[ハート ダイヤ クラブ スペード].freeze
  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  attr_reader :deck

  def initialize
    @deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << [suit, rank]
      end
    end
  end
end
