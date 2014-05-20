class TestReport < LayoutPdf
  
  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Content"]
    
  #$i = 1
  
  def initialize(test=[])
    super()
    @test = test
    
    header 'Certification Test'
    display_test
    footer
    
  end
  
  def display_test
    table test_questions,
      #header: TABLE_HEADERS,
      column_widths: TABLE_WIDTHS,
      row_colors: TABLE_ROW_COLORS
      #font_size: 9
  end
  
  def test_questions
    
    @test_questions ||= @test.map { |e| [e.id, e.content] }
    
  end
end

#[["Number", "Content", "Answer"]] +
#    @test.questions.map do |question|
#      $i +=1
#      [ "#{$i}", "#{question.content} ", 
#      "____________________________" ]
#    end