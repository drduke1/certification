class ScoresController < ApplicationController
    before_action :set_score, only: [:show, :edit, :update, :destroy]  
    before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]
    before_action :set_code, only: [:new] 
  
  
    # GET /scores
    # GET /scores.json
    def index
      if current_user.permission != ["Read Only"]
        @scores = Score.all
      else
        redirect_to home_path, notice: 'Your being logged, stop it.'
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
      @correct_answers = @answers.where(correct: true).distinct(:question_id).count(:question_id)
      @wrong_answers = @answers.where(correct: false).distinct(:question_id).count(:question_id)
    end
  
    # GET /tests/new
    def new
      #code = SecureRandom.urlsafe_base64(8)
      begin
      #if code == params[:user][:code]
        @test = Test.find(@code)
        if @score = Score.find_by_user_id_and_test_id(current_user.id,@test)
          redirect_to score_path(@score), notice: 'You have a recorded submission for the code used.'
        else
          @score = Score.new
        end
        
      #end
      rescue
        @score = Score.new
        #redirect_to root_path
      end
    end
    
  # get /tests
    # get /tests.json
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
    
    
    # POST /tests
    # POST /tests.json
    def create
      @test = Test.find(params[:test_id])
      if @score = Score.find_by_user_id_and_test_id(current_user.id,@test)
        redirect_to score_path(@score), notice: 'You have a recorded submission for the code used.'
      else
        @score = Score.new
        @score.test_id = params[:test_id]
        @score.user_id = params[:user_id]
        @answers = Answer.where(id: params[:answer_ids])
         @correct_answers = @answers.where(correct: true).distinct(:question_id).count(:question_id)
         @wrong_answers = @answers.where(correct: false).distinct(:question_id).count(:question_id)
         if @wrong_answers != 0
           @score.scores = @correct_answers.to_i  / ( @wrong_answers.to_i + @correct_answers.to_f )
         else
           @score.scores = 100
         end
        @score.answer_ids = params[:answer_ids].to_s
        #@answer_ids = []
        # @answers.each do |me|
        #   @answer_ids << Answer.find(me)
        # end
        # @score.answer_ids = @answers_ids
        respond_to do |format|
          if @score.save 
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
      
      # Before filters
      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

end
