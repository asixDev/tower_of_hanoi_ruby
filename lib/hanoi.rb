
require_relative "hanoi/version"
require_relative "hanoi/solver"


print "How many blocks?\t"
blocks = Integer(gets.chomp) rescue false
if blocks
    towers = Array.new(3) {Tower.new(blocks)}
    solver = HanoiSolver.new(towers)
    invalid = true
    while invalid do
        print "Auto or manual?(a/m)\t"
        mode = gets.chomp
        case mode
            when 'a'
                invalid = false
                solver.print_towers
                solver.solve(true)
            when 'm'
                invalid = false
                solver.solve(false)
            else
                puts "Only a/m are valid inputs, try again."
            end
    end
    
else
    puts "Needs to be an integer" end