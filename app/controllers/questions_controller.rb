class QuestionsController < ApplicationController
  #before_filter :admin_user
  before_action :set_question, only: [:show, :edit, :update, :destroy]  
  before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]


  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all  #.paginate(page: params[:page], per_page: 10)
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
    @sections = ProductSection.all
    @question = Question.new
    @product_sections = {}
    @sections.each do |section|
      @section_name = Section.find(section.section_id).name
      @product_sections["#{section.id}"] = {
        "product"          => "#{section.product_id}",
        "section"          => "#{@section_name}"
      }
    end
    4.times { @question.answers.build }
  end
  def new_tf
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
    @question.answers.build
  end

  # GET /questions/1/edit
  def edit
    @sections = Section.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params) 
    @question.product_id = question_params["#{question_params[:category]}_product_id"]
    respond_to do |format|
      if @question.save
        @answer = Answer.find_by_question_id(@question.id)
        if @answer.option == "True"
          Answer.create(option: "False", question_id: @answer.question_id, correct: false)
        end
        if @answer.option == "False"
          Answer.create(option: "True", question_id: @answer.question_id, correct: false)
        end
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        if params[:question][:question_type] == "TF"
          format.html { render action: 'new_tf' }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        else
          format.html { render action: 'new_mc' }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
        
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
      params.require(:question).permit(:ip_pbx_product_id, :ip_video_telephony_product_id, :enterprise_gateways_product_id, :ip_video_surveillance_product_id, :ip_voice_product_id, :consumer_atas_product_id, :section, :content, :question_type, :category, :product_id, :active, :user_id, answers_attributes: [ :option, :correct, :question_id ] ).
      merge user_id: current_user.id
    end    
    
    # Before filters
    def signed_in_user
    	unless signed_in?
    		store_location
	    	redirect_to signin_url, notice: "Please sign in."
	    end
    end
    
    def admin_user
      unless admin_user?
        redirect_to root_url, notice: "Administrator permissions needed."
      end
    end

end
