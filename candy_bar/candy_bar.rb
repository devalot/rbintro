class CandyBar

  # See: http://0.30000000000000004.com/

  attr_accessor(:name)

  def initialize(name)
    @name  = name
    @bites = {}
  end

  # Return % remaining
  def bites
    1.0 - total
  end

  def bite(name, size)
    @bites[name] ||= 0.0

    if (total + size) >= 1.0
      size = bites
    end

    @bites[name] += size
    total
  end

  # Returns an array of strings.
  def people
    @bites.map do |name, amount|
      "#{name} #{amount}"
    end
  end

  def average_bite_size
    return 0 if @bites.empty?
    total / @bites.size
  end

  def hogs
    @bites.select do |name, size|
      size > average_bite_size
    end.keys
  end

  private

  def total
    total = 0
    @bites.values.each {|e| total += e}
    total
  end
end
