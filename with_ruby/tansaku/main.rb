require_relative 'game/game'
require_relative 'strategy/random'

tmp = Game::Game.new(Strategy::Random.new).play

tmp = 1
