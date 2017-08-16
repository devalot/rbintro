class Reader
  def initialize(file_name)
    File.open(file_name) do |file|
      # Can use file here.
    end
  end

  def use_resource(&foobar)
    resource = open_resource
    foobar.call(resource) if foobar
    # [1,2,3].each(&foobar)
  ensure
    close_resource(resource) if resource
  end
end

reader = Reader.new("dummy")

reader.user_resource do |r|
  puts(r)
end
