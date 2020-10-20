# My Code 
# class Bottles 
#   def verse(n)
#     return ("99 bottles of beer on the wall, " +
#       "99 bottles of beer.\n" +
#       "Take one down and pass it around, " +
#       "98 bottles of beer on the wall.\n")
#   end
# end

# Incomprehensibly Concise
# class Bottles
#   def song
#     verses(99, 0)
#   end

#   def verses(hi, lo)
#     hi.downto(lo).map { |n| verse(n) }.join("\n")
#   end

#   def verse(n)
#     "#{n == 0 ? 'No more' : n} bottle#{'s' if n != 1}" +
#     " of beer on the wall, " +
#     "#{n == 0 ? 'no more' : n} bottle#{'s' if n != 1} of beer.\n" +
#     "#{n > 0  ? "Take #{n > 1 ? 'one' : 'it'} down and pass it around"
#               : "Go to the store and buy some more" }, " +
#     "#{n-1 < 0 ? 99 : n-1 == 0 ? 'no more' : n-1} bottle#{'s' if n-1 != 1}"+
#     " of beer on the wall.\n"
#   end
# end


# Speculatively General
class Bottles
  NoMore = lambda do |verse|
    "No more bottles of beer on the wall, " +
    "no more bottles of beer.\n" +
    "Go to the store and buy some more, " +
    "99 bottles of beer on the wall.\n"
  end

  LastOne = lambda do |verse|
    "1 bottle of beer on the wall, " +
    "1 bottle of beer.\n" +
    "Take it down and pass it around, " +
    "no more bottles of beer on the wall.\n"
  end

  Penultimate = lambda do |verse|
    "2 bottles of beer on the wall, " +
    "2 bottles of beer.\n" +
    "Take one down and pass it around, " +
    "1 bottle of beer on the wall.\n"
  end

  Default = lambda do |verse|
    "#{verse.number} bottles of beer on the wall, " +
    "#{verse.number} bottles of beer.\n" +
    "Take one down and pass it around, " +
    "#{verse.number - 1} bottles of beer on the wall.\n"
  end

  def song
    verses(99, 0)
  end

  def verses(finish, start)
    (finish).downto(start).map { |verse_number|
      verse(verse_number) }.join("\n")
  end

  def verse(number)
    verse_for(number).text
  end

  def verse_for(number)
    case number
    when 0 then Verse.new(number, &NoMore)
    when 1 then Verse.new(number, &LastOne)
    when 2 then Verse.new(number, &Penultimate)
    else        Verse.new(number, &Default)
    end
  end
end

class Verse
  attr_reader :number
  def initialize(number, &lyrics)
    @number = number
    @lyrics = lyrics
  end

  def text
    @lyrics.call self
  end
end