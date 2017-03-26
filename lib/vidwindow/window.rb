require "gosu"
module Vidwindow

  class Window < Gosu::Window

    DEFAULT_WIDTH = 320
    DEFAULT_HEIGHT = 200
    DEFAULT_DEPTH = 1 # bytes per pixl
    DEFAULT_SCALE = 2

    attr_reader :scale

    def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, scale: DEFAULT_SCALE, depth: DEFAULT_DEPTH, fifo:)
      @needs_redraw = true
      @scale = scale
      @fifo = fifo
      @memory = Array.new(width * height)
      super(width.to_i * scale, height.to_i * scale, {
        update_interval: (1.0/30.0),
        fullscreen: false,
      })
      self.caption = "Vidwindow"
    end

    def width=(value)
      super(value * scale)
    end

    def height=(value)
      super(value * scale)
    end

    def update
      # here we'll check for data on the fifo
    end

    def draw
      # this is where we'll blit out a bunch of pixels
    end

    def needs_cursor?
      true
    end

    def needs_redraw?
      @needs_redraw ? !(@needs_redraw = !@needs_redraw) : @needs_redraw
    end

  end

end
