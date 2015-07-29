class CandyBar

  attr_reader(:name)

  def initialize (name)
    @name  = name
    @bites = []
  end

  # Return the percentage remaining.
  def bites
    total = 0.0

    @bites.each do |n|
      total += n
    end

    (1.0 - total).round(2)
  end

  # Take a bite.
  def bite (amount)
    if bites - amount >= 0.0
      @bites.push(amount)
    end
  end
end
