class InvalidMoveError < ArgumentError
    def initialize(msg = "Illegal move")
        super
    end
end