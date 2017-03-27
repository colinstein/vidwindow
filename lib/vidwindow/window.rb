require "gosu"

module Vidwindow

  class Window < Gosu::Window

    DEFAULT_WIDTH = 3
    DEFAULT_HEIGHT = 3
    PIXEL_SCALE = 200

    def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, source:)
      @needs_redraw = true
      @memory = Memory.new(size: (width * height), source: source)
      @memory_hash = @memory.hash
      super(width.to_i * PIXEL_SCALE, height.to_i * PIXEL_SCALE, {
        update_interval: (1.0/30.0),
        fullscreen: false,
      })
      self.caption = "Vidwindow"
    end

    def update
      @memory.update
      if @memory.cells.hash != @memory_hash
        @memory_hash = @memory.cells.hash
        @needs_redraw = true
      end
    end

    def render_color(color)
      sprintf("0xff%0x%0x%0x", color, color, color).to_i(16)
    end

    def draw_pixel(x,y,color)
      x *= PIXEL_SCALE
      y *= PIXEL_SCALE
      output_color = render_color(color)
      draw_quad(
        x,             y,             output_color,
        x+PIXEL_SCALE, y,             output_color,
        x+PIXEL_SCALE, y+PIXEL_SCALE, output_color,
        x,             y+PIXEL_SCALE, output_color,
      )
    end

    def draw
      @memory.cells.each_slice(width/PIXEL_SCALE).with_index do |row, y|
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
