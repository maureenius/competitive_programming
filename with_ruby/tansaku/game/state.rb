require_relative 'action'

module Game
  class State
    SCORE_MAX = 9
    def initialize(height:, width:)
      @score = 0
      @turn = 0
      @height = height
      @width = width

      @map = {}
      random = Random.new(0)

      (1..height).each do |y|
        (1..width).each do |x|
          @map[[x,y]] = random.rand(SCORE_MAX+1)
        end
      end

      @chara_x = random.rand(1..width)
      @chara_y = random.rand(1..height)
      @map[[@chara_x, @chara_y]] = 0

      @before_action = nil
    end

    def move(action)
      @chara_x, @chara_y = @chara_x + action::DX, @chara_y + action::DY
      @score += @map[[@chara_x, @chara_y]]
      @map[[@chara_x, @chara_y]] = 0

      @before_action = action
      @turn += 1
    end

    def legal_actions
      MoveActionList.filter do |action|
        @map.key?([@chara_x + action::DX, @chara_y + action::DY])
      end
    end

    def to_string
      "\n" \
      "action: #{@before_action}\n" \
      "turn: #{@turn}\n" \
      "score: #{@score}\n" +
      (1..@height).map do |y|
        (1..@width).map do |x|
          if exist_character?(x, y)
            "@"
          elsif @map[[x,y]] == 0
            "."
          else
            @map[[x,y]]
          end
        end.join
      end.join("\n")
    end

    private

    def exist_character?(x, y)
      @chara_x == x && @chara_y == y
    end
  end
end