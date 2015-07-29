#
# This is a comment and will be ignored by Ruby.
#
class CandyBar

  attr_reader(:name, :bites)

  def initialize (name)
    @name  = name
    @bites = 5
  end

  def bite
    @bites -= 1 if @bites > 0
  end
end
