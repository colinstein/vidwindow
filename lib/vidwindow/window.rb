require "gosu"

module Vidwindow

  class Window < Gosu::Window

    DEFAULT_WIDTH = 160
    DEFAULT_HEIGHT = 144
    DEFAULT_SCALE = 8

    def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, scale: DEFAULT_SCALE, source:)
      @needs_redraw = true # we can refactor this out
      @memory = Memory.new(size: (width * height), source: source)
      @memory_hash = @memory.hash
      @scale = scale
      super(width.to_i * scale, height.to_i * scale, {
        update_interval: (1.0/30.0),
        fullscreen: false,
      })
      self.caption = "Vidwindow"
    end

    def update
      @memory.update
      if @memory.hash != @memory_hash
        @memory_hash = @memory.hash
        @needs_redraw = true
      end
    end

    def render_color(color)
      sprintf("0xff%0x%0x%0x", color, color, color).to_i(16)
    end

    def draw_pixel(x,y,color)
      x *= @scale
      y *= @scale
      output_color = render_color(color)
      draw_quad(
        x,        y,        output_color,
        x+@scale, y,        output_color,
        x+@scale, y+@scale, output_color,
        x,        y+@scale, output_color,
      )
    end

    def draw
      @memory.each_row(width/@scale).with_index do |row, y|
        row.each.with_index do |col, x|
          draw_pixel(x,y,col)
        end
      end
    end

    def needs_cursor?
      true
    end

    def needs_redraw?
      @needs_redraw ? !(@needs_redraw = !@needs_redraw) : @needs_redraw
    end

  end

end
