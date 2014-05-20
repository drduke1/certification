class TestReport < LayoutPdf
  
  #TABLE_WIDTHS = [20, 400, 200]
  #TABLE_HEADERS = ["ID", "Content", "Answer"]

  def initialize(test=[], answer=[])
    super()
    @test_questions = test
    @all_answers = answer
    
    header 'Certification Test'
    display_test
    footer
    
  end
  
  def display_test
    table test_questions do
      #row(0).font_style = :bold
      self.header = true
      #self.row_colors = ['DDDDDD']
      self.column_widths = [40, 300, 200]
    end
      #headers: TABLE_HEADERS,
      #column_widths: TABLE_WIDTHS,
      #row_colors: TABLE_ROW_COLORS
      #font_size: 9
        
  end
  
  def test_questions
    [['#', 'Question']] +
    @test_me ||= @test_questions.map { |e| [e.id, e.content] } +
    #@all_answers.each do |a| a.content end
    @answer_me ||= @all_answers.flatten.map { |a| [a.content] }
  end
end

#[["Number", "Content", "Answer"]] +
#    @test.questions.map do |question|
#      $i +=1
#      [ "#{$i}", "#{question.content} ", 
#      "____________________________" ]
#    end