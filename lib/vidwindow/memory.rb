require "forwardable"

module Vidwindow
  class Memory
    extend Forwardable

    DEFAULT_SIZE = 320 * 200
    DEFAULT_VALUE = 0

    def_delegator :@cells, :each
    def_delegator :@cells, :hash
    def_delegator :@cells, :fetch, :read
    def_delegator :@cells, :[]=, :write
    def_delegator :@cells, :each_slice, :each_row

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
