
require "io/console"
require_relative "tower"

class HanoiSolver
    def initialize (towers)
        @t1 = towers[0]
        @t2 = towers[1]
        @t3 = towers[2]
    end

    def print_towers(numbered = false)
        puts
        towers = [@t1, @t2, @t3]
        row_length = 3 + 2 *towers[0].blocks.size
        (0..towers[0].blocks.size-1).each do |index|
            output_towers = "|"
            towers.each {|tower| output_towers << ("*" * (2 * tower.blocks[index]+1)).center(row_length+4) << "|"}
            puts output_towers
        end
        if numbered
            output_labels = "|"
            (1..3).each do |index|
                output_labels << (index.to_s).center(row_length+4) << "|"
            end
            puts output_labels
        end
        puts "Made #{Tower.moves} moves"
    end

    def work(n, from, to, helper)
        return if n == 0
        work(n - 1, from, helper, to)
        from.move(to)
        STDOUT.clear_screen
        print_towers
        sleep 0.5
        work(n-1, helper, to, from)
    end

    def unsolved?
        [@t2, @t3].none?{|tower| tower.blocks.size == tower.block_count}
    end

    def manual_choice(number)
        case number
        when 1
            @t1
        when 2
            @t2
        when 3
            @t3
        end
    end

    def solve(auto)
        if auto then work(@t1.blocks.size, @t1, @t3, @t2)
        else 
            show_message = false
            while unsolved?
                STDOUT.clear_screen
                print_towers(true)
                if show_message
                    case show_message
                    when 1
                        puts "Illegal move, nothing happened"
                    when 2
                        puts "must be a different integer from 1 to 3"
                    when 3
                        puts "must be an integer from 1 to 3"
                    end
                    show_message = false
                end
                puts "From: "
                from = Integer(gets.chomp) rescue false
                if from && (1..3).to_a.include?(from)
                    puts "To: "
                to = Integer(gets.chomp) rescue false
                if to && (1..3).to_a.include?(to) && from != to
                    manual_choice(from).move(manual_choice(to)) rescue show_message = 1
                else
                    show_message = 2
                    next
                end
                else
                    show_message = 3
                    next
                end
            end
            print_towers(true)
            puts "Finished!"
        end
    end

    private :manual_choice, :work
end