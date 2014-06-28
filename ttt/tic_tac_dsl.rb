require 'complex'
require_relative 'tic_tac_board.rb'

class << self
  def board
    @board ||= Board.new
  end

  def start
    @board = nil
    puts board.to_s
    "The player using 'x' gets to go first."
  end

  def method_missing(meth, *args)
    if %W[x o].include?(player = meth.to_s)
      message = case
      when (args.size != 1) then "Usage: #{player} left|right|top|bottom|center (left|right|top|bottom|center)*"
      when board.game_over? then game_over_message
      when !board.the_turn_of?(player) then "It is not time for '#{player}' to move."
      else
        if board.space_occupied?(args[0])
          "That space is already occupied."
        else
          board.place_marker(player, args[0])
          case
          when board.game_won? then winning_message
          when board.game_tied? then tied_message
          else "The player using '#{board.the_turn_of?('x') ? 'x' : 'o'}' goes next."
          end
        end
      end
      puts board.to_s
      return message
    else
      super
    end
  end

  def center(arg = Complex(0,0)); arg; end
  def left(arg = center); arg + Complex(-1,0); end
  def right(arg = center); arg + Complex(1,0); end
  def top(arg = center); arg + Complex(0,1); end  
  def bottom(arg = center); arg + Complex(0,-1); end

  alias_method :middle, :center

private
  def winning_message
    "Game over. '#{board.the_turn_of?('x') ? 'o' : 'x'}' is the winner."    
  end

  def tied_message
    "Game over. No one won. Such is life."
  end

  def game_over_message
    "Maybe you missed it, but the game already ended."
  end
end

$VERBOSE = nil
puts <<-END_OF_BANNER

+-----| Tic-tac-DSL
      |            
      | A tiny two-player tic-tac-toe DSL.
      | 
      | start            new game
      | x top [right]    place an X in position
      | o center [left]  place an O in position
      | exit             exit (!)


END_OF_BANNER
