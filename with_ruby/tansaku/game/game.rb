require_relative 'state'
require_relative '../strategy/random'

module Game
  class Game
    HEIGHT = 3
    WIDTH = 4
    END_TURN = 4
    def initialize(strategy)
      @maze = State.new(height: HEIGHT, width: WIDTH)
      @strategy = strategy
    end

    def play
      initial_turn

      (1..END_TURN).each do
        play_turn
      end
    end

    private

    def initial_turn
      puts @maze.to_string
    end

    def play_turn
      action = @strategy.select_action(@maze.legal_actions)
      @maze.move(action)
      puts @maze.to_string
    end
  end
end
