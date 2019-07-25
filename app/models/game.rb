class Game < ApplicationRecord
  attr_accessor :board, :turn, :valid_subgames
  after_initialize :set_attributes

  PLAYERS = %w[X O].freeze

  def set_attributes
    @board = new_board
    @turn = PLAYERS.sample
    @valid_subgames = []
  end

  def as_json
    {
      id: id,
      board: new_board,
      turn: @turn,
      winner: winner || "",
      valid_subgames: [0,1,2,3,4,5,6,7,8]
    }
  end

  def add_move(subgame, cell)
    @board[subgame][cell] = @turn
    winner = check_for_winner(subgame)
  end

  def check_for_winner(subgame)
    # win sets are vertial, horizontal, or diagonal
    sets = [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,6,9],
      [1,5,9], [3,5,8]
    ]

    subgame = @board[subgame]

    # return true or false if there is a winner
    sets.any? do |set|
      # replace X's with 1 and O's with 2
      set = set.map { |set| subgame[set].gsub("X", 1).gsub("O", 2) }
      # remove empty win set possibilities
      set = set.reject {|set| subgame[set].any?(&:blank?) }
      # return true if a single win set adds to 3 (X wins) or 6 (Y wins)
      subgame[set].reduce(&:+) == 3 || 6
    end
  end

  private

  def new_board
    @board = Array.new(9, Array.new(9, ""))
  end
end
