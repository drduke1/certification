class ScoresController < ApplicationController
    before_action :set_score, only: [:show, :edit, :update, :destroy]  
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
      
    end
  
    # GET /tests/new
    def new
      @score = Score.new
      @test = Test.find(params[:format])
      
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
          format.html { redirect_to @score, notice: 'Test was successfully created.' }
          format.json { render action: 'show', status: :created, location: @score }
        else
          format.html { render action: 'new' }
          format.json { render json: @score.errors, status: :unprocessable_entity }
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
  
    # DELETE /tests/1
    # DELETE /tests/1.json
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
