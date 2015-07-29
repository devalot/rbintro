class CandyBar

  attr_reader(:name)

  def initialize (name)
    @name  = name
    @bites = {}
  end

  # Return the percentage remaining.
  def bites
    total = 0.0
    @bites.values.each {|n| total += n}
    (1.0 - total).round(2)
  end

  # Who ate the most?
  def hog
    max_person = nil
    max_bite   = 0.0

    @bites.each do |person, bite|
      if bite > max_bite
        max_person = person
        max_bite   = bite
      end
    end

    max_person
  end

  # Return an audit log of bites.
  def people
    @bites.map do |person, amount|
      "#{person} ate #{amount * 100}%"
    end
  end

  # Take a bite.
  def bite (amount, person)
    return if bites - amount < 0.0

    so_far = @bites[person] || 0.0
    @bites[person] = so_far + amount
  end
end
