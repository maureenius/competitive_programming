module Game
  class Action; end

  class MoveNorth < Action
    DX = 0
    DY = -1
  end

  class MoveSouth < Action
    DX = 0
    DY = 1
  end

  class MoveEast < Action
    DX = 1
    DY = 0
  end

  class MoveWest < Action
    DX = -1
    DY = 0
  end

  class MoveActionList
    ACTIONS = [MoveNorth, MoveSouth, MoveEast, MoveWest]

    def self.filter(&block)
      ACTIONS.filter(&block)
    end
  end
end