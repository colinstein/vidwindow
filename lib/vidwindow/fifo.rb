require 'forwardable'

module Vidwindow
  class Fifo

    extend Forwardable

    def_delegators :@fifo, :close, :to_io

    def initialize(file)
      raise ArgumentError.new("No such file") unless File.exist?(file)
      @fifo = File.open(file, "r+")
      at_exit { @fifo.close }
    end

    def read(bytes)
      @fifo.read_nonblock(bytes)
    rescue IO::EAGAINWaitReadable
    end
    # This seems like a good spot for io::read_nonblock
    # go off and read some fixed number of bytes. on return, swap buffers
    # maybe do that in the update loop?
  end

end
