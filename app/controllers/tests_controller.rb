class TestsController < ApplicationController
  before_filter :permitted
  before_action :set_test, only: [:show, :edit, :update, :destroy]  
    before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]
  
  
    # GET /tests
    # GET /tests.json
    def index
      @tests = Test.all
      #@tests = Test.paginate(page: params[:page], per_page: 10)
    end
    
    # GET /tests/1
    # GET /tests/1.json
    def show
      respond_to do |format|
        format.html
        format.pdf do
          @pdf = []
          @test = Test.find(params[:id])
            
          #different
          @test_questions = @test.questions.includes(:answers)
          #end different  
            
          #@test_questions = @test.questions
          #answers = Answer.all
          #@all_answers = answers.group_by(&:question_id)
          #@test_questions.each do |q|
            #@pdf << q
            #@pdf += @all_answers[q.id]
          #end
          pdf = TestReport.new(@test_questions, @test)
          send_data pdf.render, filename: 'certification_test.pdf', type: 'application/pdf' , disposition: 'inline' 
        end
      end
    end
  
    # GET /tests/new
    def new
      @test = Test.new
      @questions = Question.all
    end
    
    # GET /tests/newgen
    def newgen
      @test = Test.new
      @sections = ProductSection.all
      @question = Question.new
      @product_sections = {}
        @sections.each do |section|
          @section_name = Section.find(section.section_id).name
          @product_sections["#{section.id}"] = {
            "product"         => "#{section.product_id}",
            "section"         => "#{@section_name}"
          }
        end
    end
    
    # GET /tests/1/edit
    def edit
      @questions = Question.all
    end
  
    # POST /tests
    # POST /tests.json
    def create
      @test = Test.new(test_params)
      @questions = Question.all
      respond_to do |format|
        if @test.save 
          format.html { redirect_to @test, notice: 'Test was successfully created.' }
          format.json { render action: 'show', status: :created, location: @test }
        else
          format.html { render action: 'new' }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def creategen
      @test = Test.new(test_params)
      # Check for total questions and percentage parameter
      if (params[:test][:total] != "") && (params[:test][:percent].present?)
        @percentages = params[:test][:percent]
        @total_questions = params[:test][:total]
        @section_names = params[:test][:section]
        @questions = []
        @question_ids = []
        @section_names.each_with_index do |me, index|
          @section_percent = @percentages.at(index)
          @decimal_section_percent = @section_percent.to_i*0.01
          # Get number of questions based on total and percentage
          @calc_section_questions = @total_questions.to_i * @decimal_section_percent
          # Get calculated number of questions for this section randomly
          @questions = Question.where(section: me).order("rand()").limit(@calc_section_questions)
          # Append the random question ids into the array
          @questions.each do |q|
              @question_ids << q.id
          end
        end
        @test.question_ids = @question_ids
        @test.section = @section_names.to_s
        @test.percent = @percentages.to_s
        @test.total = @total_questions.to_s
      end
      respond_to do |format|
        if @test.save 
          format.html { redirect_to @test, notice: 'Test was successfully created.' }
          format.json { render action: 'show', status: :created, location: @test }
        else
          @sections = ProductSection.all
          @question = Question.new
          @product_sections = {}
            @sections.each do |section|
              @section_name = Section.find(section.section_id).name
              @product_sections["#{section.id}"] = {
                "product"         => "#{section.product_id}",
                "section"         => "#{@section_name}"
              }
            end
          format.html { render action: 'newgen' }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /tests/1
    # PATCH/PUT /tests/1.json
    def update
      respond_to do |format|
        @test.question_ids = []
        if @test.update(test_params)
          format.html { redirect_to @test, notice: 'Test was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def count_questions
      @count = Question.where(section: params[:section]).count
       respond_to do |format|
          format.html 
          format.js 
        end
    end
  
    # DELETE /tests/1
    # DELETE /tests/1.json
    def destroy
      @test.destroy
      respond_to do |format|
        format.html { redirect_to tests_url }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_test
        @test = Test.find(params[:id])
        @question = Test.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def test_params
        params.require(:test).permit(:name, :user_id, :type, :category, :description, :total, :question_ids => [], :section => [], :percent => [], questions_attributes: [ :id ] ).
        merge user_id: current_user.id
      end    
      
      # Before filters
      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

end
