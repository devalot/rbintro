class People
  def initialize(names)
    @names = names
  end

  def match(name)
    @names.each do |n|
      if n == name
        throw(:foobar, name)
      end
    end
  end
end


x = catch(:foobar) do

  p = People.new(["Peter", "Paul"])
  p.match("Peter")

end

puts x.inspect
