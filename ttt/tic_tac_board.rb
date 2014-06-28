require 'complex'

class Complex
  def tic_tac_toe_index
    4 - 3 * (imag <=> 0) + (real <=> 0)
  end
end

class Board
  attr_accessor :layout
  def initialize
    self.layout = [nil] * 9
  end

  def game_won?
    [ [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],[2,5,8],
      [0,4,8],[2,4,6]
    ].any? {|patt|  ['xxx','ooo'].include?(layout.values_at(*patt).join) }
  end

  def game_tied?
    layout.compact.size == 9
  end

  def game_over?
    game_won? || game_tied?
  end

  def count_of(x_or_o)
    layout.select {|spot| spot == x_or_o }.size
  end

  def the_turn_of?(x_or_o)
    count = Hash['x', count_of('x'), 'o', count_of('o')]
    (x_or_o == 'x') ? (count['x'] == count['o']) : (count['o'] < count['x'])
  end

  def space_occupied?(location)
    !!layout[location.tic_tac_toe_index]
  end

  def place_marker(marker, location)
    unless space_occupied?(location)
      layout[location.tic_tac_toe_index] = marker
    end
  end

  def to_s
    (0..2).map do |row|
      (0..2).map {|col| ' ' + symbol(layout[row*3+col]) + ' ' }.join '|'
    end.join "\n---+---+---\n"
  end

  def symbol(char)
    char.nil? ? ' ' : char
  end

end

