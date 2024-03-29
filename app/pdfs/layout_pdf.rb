class LayoutPdf < Prawn::Document
  
  #TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  #TABLE_FONT_SIZE = 9
  #TABLE_BORDER_STYLE = :grid
  
  def initialize(default_prawn_options={
    
  })
    super(default_prawn_options)
    font_size 10
  end
    
  def header(title=nil)
    image "#{Rails.root}/app/assets/images/certification_logo.png", height: 50
    text "Grandstream Networks", size: 18, style: :bold, align: :center
    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end  
  
  def footer
    # yippie
  end
end