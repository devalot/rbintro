################################################################################
# A big mess to wrap array elements so they fit within a slide and
# don't run off the side of a page.
Array.class_exec do
  MAX_LINE_LEN = 50

  def inspect
    items = map(&:inspect)

    if items.reduce(0) {|a, i| a + i.length} > MAX_LINE_LEN
      gathered = items.reduce([Array.new]) do |lines, item|
        if (lines.last + [item]).join(', ').length > MAX_LINE_LEN
          lines << [item]
        else
          lines.last << item
        end

        lines
      end

      '[ ' + gathered.map {|line| line.join(', ')}.join(",\n     ") + ' ]'
    else
      '[' + items.join(', ') + ']'
    end
  end
end
