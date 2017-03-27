module Vidwindow
  class Memory
    DEFAULT_SIZE = 320 * 200
    DEFAULT_VALUE = 0

    attr_reader :cells

    def initialize(size: DEFAULT_SIZE, value: DEFAULT_VALUE, source:)
      raise ArgumentError.new("memory too small") if size <= 0
      @cells = Array.new(size, value)
      @source = source
      @cursor = 0
    end

    def update
      return unless new_bytes = @source.read(@cells.size - @cursor)
      [*new_bytes].each.with_index { |b,i| @cells[@cursor+i] = b }
      @cursor = (@cursor + new_bytes.size) % @cells.size
    end

  end
end
