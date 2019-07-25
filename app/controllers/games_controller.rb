class GamesController < ApplicationController

  def update
    game = Game.find(params[:id])
    game.add_move(params[:subgame].to_i, params[:cell].to_i)

    render json: @game.as_json
  end

  def create
    @game = Game.create!

    Rails.cache.fetch("game-#{@game.id}") do
      @game
    end

    render json: @game.as_json
  end
end
