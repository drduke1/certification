class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]  
  before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]


  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.paginate(page: params[:page], per_page: 10)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  	@answer = Answer.new
  end

  # GET /questions/new
  def new
    @question = Question.new    
    @products = Product.all
  end
  def new_mc
    @question = Question.new
    4.times { @question.answers.build }
  end
  def new_tf
    @question = Question.new
    @question.answers.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        @answer = Answer.find_by_question_id(@question.id)
        if @answer.content == "True"
          Answer.create(content: "False", question_id: @answer.question_id, correct: false)
        end
        if @answer.content == "False"
          Answer.create(content: "True", question_id: @answer.question_id, correct: false)
        end
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :question_type, :category, :product_id, :active, :user_id, answers_attributes: [ :content, :correct, :question_id ] ).
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
