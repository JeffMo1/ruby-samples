DIGITS = [
  ' *     *  *     *  *  *  *  * ',  
  '* *  *  *  ** **  *    ** ** *',
  '       *  *  *  *  *     *  * ',
  '* *  **    *  *  ** *  ** *  *',
  ' *     *  *     *  *     *  * '
]

def digit_slice(row, digit, zoom)
  reference = DIGITS[row][digit*3, 3]
  symbol = row.odd? ? '|' : '-'
  rendered = reference.gsub('*', symbol)
  rendered[0] + rendered[1] * zoom + rendered[2]
end

def lcd_draw(digits, zoom)
  (0..4).each do |row|
    repeat = row.odd? ? zoom : 1
    (1..repeat).each { puts digits.map {|digit| digit_slice(row, digit, zoom) }.join(' ') }
  end
end

if ARGF.argv.size == 2 && ARGF.argv.each {|arg| !!arg.match(/^[0-9]+$/) }
  digits = ARGF.argv.first.each_char.map(&:to_s).map(&:to_i)
  zoom = ARGF.argv.last.to_i
  lcd_draw(digits, zoom)
else
  puts "Usage: ruby lcd.rb number_to_display zoom_factor"
end
