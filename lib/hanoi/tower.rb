require_relative "errors"
class Tower

    @@filled_exists = false
    @@moves = 0
    attr_reader :blocks

    def self.moves
        @@moves
    end

    def initialize(blocks)
        @blocks = Array.new(blocks, 0)
        unless @@filled_exists
            (1..blocks).each do |block|
                @blocks[block-1] = block
            end
            @@filled_exists = true
        end
    end

    def block_count
        @blocks.count {|e| e > 0}
    end

    def topmost
        return @blocks.find {|e| e > 0} unless block_count == 0
        return 0
    end

    def topmost_index
        return @blocks.size-1 if topmost == 0
        return @blocks.index(topmost)
    end

    def move(other_tower)
        raise InvalidMoveError if block_count == 0
        top_index = topmost_index
        other_top_index = other_tower.topmost_index
        unless other_tower.topmost == 0 
            other_top_index -= 1 
            raise InvalidMoveError if @blocks[top_index] > other_tower.blocks[other_top_index+1]
        end
        @blocks[top_index], other_tower.blocks[other_top_index] = other_tower.blocks[other_top_index], @blocks[top_index]
        @@moves += 1
    end
end