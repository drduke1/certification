class ScoresController < ApplicationController
    before_filter :permitted, only: [:edit, :update, :destroy]
    before_action :set_score, only: [:show, :edit, :update, :destroy]  
    before_action :signed_in_user, only: [:new, :new_form, :index, :edit, :show, :update, :destroy]
    before_action :set_code, only: [:new] 
    before_action :taken_before, only: [:new]
    respond_to :html, :js
  
  
    # GET /scores
    # GET /scores.json
    def index
      if current_user.permission != ["Read Only"]
        @scores = Score.all
      else
        @scores = Score.where(user_id: current_user.id)
      end
    end
    
    # GET /scores/1
    # GET /scores/1.json
    def show
      if current_user.permission == ["Read Only"]
        if @score.user_id != current_user.id
          redirect_to home_path, notice: 'Your being logged, stop it.'
        end
      end
#      if @score.passed.nil?
#        @passed = Test.find(@score.test_id).minimum
#        if @score.scores >= @passed.to_i
#          @score.passed = true
#        else
#          @score.passed = false
#        end
#      end
      @each_answer = []
      @scores = @score.answer_ids.scan(/\d+/).map(&:to_i)
      #@scores = eval(@score.answer_ids)  # This executes string as Ruby code :D, isn't as fast as scan()
      @scores.each do |me|
        @each_answer << Answer.find(me)
      end
      # This code block works, does same thing as scan().map() above just parses with JSON.
      #      input = @score.answer_ids
      #      require 'json'
      #      ids = JSON.parse(input).map(&:to_i)
      #      @answers = []
      #      @answers += Answer.find(ids)
      
      # Get correct & wrong answers count to show Tester
      @answers = Answer.where(id: @scores)
      @correct_answers = @answers.where(correct: true).distinct(:question_id)
      @wrong_answers = @answers.where(correct: false).distinct(:question_id)
      
      @correct_answers_count = @correct_answers.count(:question_id)
      @wrong_answers_count = @wrong_answers.count(:question_id)
      
      # Get sections and number wrong from section
      @wrong_sections = []
      @wrong_answers.each do |a|
        @wrong_sections << a.question.section 
      end
      @string_wrong = @wrong_sections.map(&:inspect).join(', ')
      @string_wrong_nospace = @string_wrong.gsub(/\s+(?=[a-zA-Z])/, "-")
      @count = WordsCounted.count(@string_wrong_nospace) 
    end
  
    # Get /scores/new_form
    def new_form
      #if @score = Score.find_by_user_id_and_test_id(current_user.id,@test)
      #  redirect_to score_path(@score), notice: 'You have a recorded submission for the code used.'
      #else
        #@code = take_test
        #redirect_to new_score_path(request.parameters)
      #end
    end
    
    def time
      unless current_user.time != nil
        @time = Time.now
        @user = User.find(current_user.id)
        @user.update_attributes(time: @time)
      end
    end
    
    # GET /scores/new
    def new
      #code = SecureRandom.urlsafe_base64(8)
      #begin
        @test = Test.find(@code)
        
          #Get time limit
          @hours = @test.hour
          @minutes = @test.minute
          @hour = @hours.to_i
          @minute = @minutes.to_i
          @deadline = @hour + @minute
          @score = Score.new()
          @user_time = current_user.time
          if (@user_time != nil) && (@deadline != 0)
            @submit_deadline2 = @user_time.to_time
            @submit_deadline = @submit_deadline2 + @hour.hour + @minute.minute
            @time = @user_time
            if Time.now < @submit_deadline
              @start = @user_time.to_time
              @difference = Time.diff(@submit_deadline, Time.now, '%y, %M, %d and %h:%m:%s')
            else
              @difference = "SAVE" #{:year=>0, :month=>0, :week=>0, :day=>0, :hour=>0, :minute=>0, :second=>0, :diff=>"00:00:00"}
            end            
          else
            @time = ""
            @difference = ""          
          end
        respond_to do |format|
          format.html
          format.json { render action: 'time' }
        end
      #rescue
        #@score = Score.new
       # redirect_to root_path
      #end
    end
    
  # get /scores
    # get /scores.json
    def edit
      @score = Score.new(score_params)
      @test = Test.find(params[:score][:test_id])
      @test_questions = @test.questions.includes(:answers)
      respond_to do |format|
        if @score.save 
          format.html { redirect_to @test, notice: 'Test was successfully created.' }
          format.json { render action: 'show', status: :created, location: @test }
        else
          format.html { render action: 'new' }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end
    
    
    # POST /scores
    # POST /scores.json
    def create
      @test = Test.find(params[:test_id])
      if @score = Score.find_by_user_id_and_test_id(current_user.id,@test)
        redirect_to score_path(@score), notice: 'You have a recorded submission for the code used.'
      else
        @score = Score.new
        @score.test_id = params[:test_id]
        @score.user_id = params[:user_id]
        @passed = @test.minimum          
        @answers = Answer.where(id: params[:answer_ids])
        @correct_answers = @answers.where(correct: true).distinct(:question_id).count(:question_id)
        @wrong_answers = @answers.where(correct: false).distinct(:question_id).count(:question_id)
        
        #Get total number of questions
        @test = Test.find(params[:test_id])
        @total_questions = []
        @test.questions.each do |q|
          @total_questions << Answer.where(question_id: q)
        end
        @total = @total_questions.count 
        @score.scores = @correct_answers.to_i  / @total.to_f
        if @score_calc == 1.0
          @score.scores = 100
          #@score.scores = @correct_answers.to_i  / ( @wrong_answers.to_i + @correct_answers.to_f )
        end
        @score_digit = @score.scores * 100
        if @score_digit >= @passed.to_d
          @score.passed = true
        else
          @score.passed = false
        end
        if params[:answer_ids]
          @score.answer_ids = params[:answer_ids].to_s
        else
          @score.answer_ids = "[]"
          @score.passed = false
          @score.scores = 0
        end
        
        #@answer_ids = []
        # @answers.each do |me|
        #   @answer_ids << Answer.find(me)
        # end
        # @score.answer_ids = @answers_ids
        respond_to do |format|
          if @score.save 
            @user = User.find(current_user.id)
            @user.update_attributes(time: nil)
            ScoreMailer.score_email(@score, @correct_answers, @wrong_answers).deliver
            format.html { redirect_to @score, notice: 'Test was successfully created.' }
            format.json { render action: 'show', status: :created, location: @score }
          else
            format.html { render action: 'new' }
            format.json { render json: @score.errors, status: :unprocessable_entity }
          end
        end
      end
    end
    
    
    # PATCH/PUT /scores/1
    # PATCH/PUT /scores/1.json
    def update
      respond_to do |format|
        @score.question_ids = []
        if @score.update(score_params)
          format.html { redirect_to @score, notice: 'Test was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @score.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /scores/1
    # DELETE /scores/1.json
    def destroy
      @score.destroy
      respond_to do |format|
        format.html { redirect_to scores_url }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def taken_before
        @test = Test.find(@code)
        if @score = Score.find_by_user_id_and_test_id(current_user.id,@test)
          redirect_to score_path(@score), notice: 'You have a recorded submission for the code used.'
        end
      end
    
      def set_score
        @score = Score.find(params[:id])
      end
      
      def set_code
        @code = params[:user][:code]
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def score_params
        params.require(:score).permit(:name, :user_id, :test_id, :answer_ids => [] )
      end    
      
      def take_test
        params.permit(:code )
      end 
      
      # Before filters
      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

end
