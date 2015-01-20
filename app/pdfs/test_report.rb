class TestReport < LayoutPdf

  def initialize(test_questions=[], test)
    super()
    @test_questions = test_questions
    @test = test
    @i = 0
    
    header "#{@test.name}"
    move_down 20
    @test_questions.each do |q|
      @i += 1
      span(800, :position => :left) do
        group do
        text "#{@i}. " + "#{q.content}"
        move_down 10
          @a = ("a".."z").to_a
          q.answers.each_with_index do |answer, i|
            if answer
              text "#{@a[i]}.  " + "#{answer.option}", :indent_paragraphs => 15
              move_down 4
            end
          end
        move_down 10
        end
      end
    end
    
    
    #display_test
    footer
    
  end
  
  def display_test
    table test_questions do
      #row(0).font_style = :bold
      self.header = true
      #self.row_colors = ['DDDDDD']
      self.column_widths = [300, 200]
    end
      #headers: TABLE_HEADERS,
      #column_widths: TABLE_WIDTHS,
      #row_colors: TABLE_ROW_COLORS
      #font_size: 9
        
  end
  
  def test_questions
    [['Question', 'Answer']] +       
    @the_pdf ||= @pdf.map { |q| [ (if q.class == Question
                                      q.content 
                                   elsif q.class == Answer
                                      q.option
                                   end), "" ] }
  end
end