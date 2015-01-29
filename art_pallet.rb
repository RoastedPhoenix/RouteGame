require 'fox16'
include Fox
class PaintButton < FXButton
  def initialize(parent, color, label, txt_color)
    super(parent, label, :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 75, :height => 75)
    @window = self.parent.parent
    self.backColor = color
    self.textColor = txt_color
    self.connect(SEL_COMMAND) do
      @window.colors = self.backColor
    end
  end
end


class AgentSmith < FXButton
  def initialize(parent)
    super(parent, 'Agent Smith', :opts => LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 2, :height => 2)
    self.backColor = :black
    @window = self.parent.parent
    self.connect(SEL_COMMAND) do
      FXMessageBox.warning(app, MBOX_OK, "I've Won Mr.Anderson", "Agent Smith Destroyed the Program")
      Destroyed_The_Matrix
    end
  end
end
class EaselButton < FXButton
  def initialize(parent)
    super(parent, '', :opts => LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 10, :height => 10)

    self.backColor = :white
    @window = self.parent.parent
    self.connect(SEL_MOTION) do
      if @window.brushmode == 1
        self.backColor = @window.colors
      else
      end
    end
    self.connect(SEL_COMMAND) do
      if @window.brushmode == 0
        self.backColor = @window.colors
      else
      end
    end
    self.connect(SEL_RIGHTBUTTONPRESS) do
      if @window.brushmode == 1
        @window.brushmode = 0
      elsif @window.brushmode == 0
        @window.brushmode = 1
      end
    end
  end
end
class FillButton < FXButton
  def initialize(parent)
    super(parent, 'Fill', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 75, :height => 75)
    self.backColor = :white
    @window = self.parent.parent
    self.connect(SEL_COMMAND) do
      @window.matrixarray.each do |button|
        button.backColor = @window.colors
      end
    end
  end
end
class ColorSelector < FXButton
  def initialize(parent)
    super(parent, 'Custom...', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 75, :height => 75)
    @window = self.parent.parent
    self.backColor = :grey
    self.connect(SEL_COMMAND) do
      @select_color = FXColorDialog.new(@window, '', 0, 0, 0, 100, 100)
      @select_color.width = 500
      @select_color.height = 300
      @result = @select_color.execute
      if @result == 1
        @window.custom_color = @select_color.rgba
        @window.colors = @window.custom_color
        @window.custom_button_fill
      end
    end
  end
end
class ArtEasel < FXMainWindow
  attr_accessor :colors, :fill, :matrixarray, :brushmode, :custom_color
  def initialize(app)
    super(app, 'Easel')
    @custom_counter = 1
    @x = 0
    @y = 0
    @brushmode = 0
    @colors = :white
    @fill = 0
    savebutton = FXButton.new(self, 'Save')
    savebutton.connect(SEL_COMMAND) do
      image = FXPNGImage.new(app, nil, :opts => IMAGE_KEEP, :width => 800, :height => 600)
      image.create
      brush = FXDCWindow.new(image)
      @matrixarray.each do |pixel|
        brush.foreground = pixel.backColor
        brush.fillRectangle(@x, @y, 10, 10)
        if @y == 590
          @x = @x + 10
          @y = 0
        else
          @y = @y + 10
        end
      end
      @filename = FXInputDialog.getString(@window, app, "File Name?", "What is the file name?", nil)
      if @filename != nil
        f = FXFileStream.open('./'+@filename+'.png', FXStreamSave)
        image.restore
        image.savePixels(f)
        f.close
        end
    end
    @button_color = 0
    @matrixarray = []
    self.backColor = :tan
    @mtx = FXMatrix.new(self, 60, :opts => MATRIX_BY_ROWS)
    @mtx.hSpacing = 0
    @mtx.vSpacing = 0
    @mtx.numColumns = 80
    @mtx.numRows = 60
    @mtx.backColor = :tan

    #Do not try to paint on a canvas that is impossible. Instead realize the truth that there is no canvas.
    #It is just the lack of spacing by the Matrix
    4800.times do
      @matrixarray.push EaselButton.new(@mtx)
    end
    @mtxreloaded = FXMatrix.new(self, 2, :opts => MATRIX_BY_COLUMNS)
    @mtxreloaded.numRows = 2
    @mtxreloaded.numColumns = 10
    @mtxreloaded.hSpacing = 0
    @mtxreloaded.vSpacing = 0
    @mtxreloaded.backColor = :tan
    PaintButton.new(@mtxreloaded, :red, 'Red', :black)
    PaintButton.new(@mtxreloaded, :orange, 'Orange', :black)
    PaintButton.new(@mtxreloaded, :yellow, 'Yellow', :black)
    PaintButton.new(@mtxreloaded, :lightGreen, 'LightGreen', :black)
    PaintButton.new(@mtxreloaded, :green, 'Green', :black)
    PaintButton.new(@mtxreloaded, :cyan, 'Cyan', :black)
    PaintButton.new(@mtxreloaded, :blue, 'Blue', :white)
    PaintButton.new(@mtxreloaded, :purple, 'Purple', :black)
    PaintButton.new(@mtxreloaded, :magenta, 'Magent', :black)
    PaintButton.new(@mtxreloaded, :peachPuff2, 'Peach', :black)
    PaintButton.new(@mtxreloaded, :saddleBrown, 'Brown', :white)
    PaintButton.new(@mtxreloaded, :black, 'Black', :white)
    PaintButton.new(@mtxreloaded, :white, 'White', :black)
    ColorSelector.new(@mtxreloaded)
    @custom1 = PaintButton.new(@mtxreloaded, :white, 'Custom 1', :black)
    @custom1.disable
    @custom2 = PaintButton.new(@mtxreloaded, :white, 'Custom 2', :black)
    @custom2.disable
    @custom3 = PaintButton.new(@mtxreloaded, :white, 'Custom 3', :black)
    @custom3.disable
    @custom4 = PaintButton.new(@mtxreloaded, :white, 'Custom 4', :black)
    @custom4.disable
    @custom5 = PaintButton.new(@mtxreloaded, :white, 'Custom 5', :black)
    @custom5.disable
    FillButton.new(@mtxreloaded)
    @mtxrevolutions = FXMatrix.new(self, 1)
    @mtxrevolutions.backColor = :tan
    AgentSmith.new(@mtxrevolutions)

    def custom_button_fill
      if @custom_counter == 1
        @custom1.backColor = @custom_color
        @custom1.enable
        @custom_counter = 2
      elsif @custom_counter == 2
        @custom2.backColor = @custom_color
        @custom2.enable
        @custom_counter = 3
      elsif @custom_counter == 3
        @custom3.backColor = @custom_color
        @custom3.enable
        @custom_counter = 4
      elsif @custom_counter == 4
        @custom4.backColor = @custom_color
        @custom4.enable
        @custom_counter = 5
      elsif @custom_counter == 5
        @custom5.backColor = @custom_color
        @custom5.enable
        @custom_counter = 1
      end
    end
  end

  def create
    super
    self.show(PLACEMENT_SCREEN)
  end
end


app = FXApp.new
ArtEasel.new(app)
app.create
app.run
# ~JΩSH G.



