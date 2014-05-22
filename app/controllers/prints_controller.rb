class PrintsController < ApplicationController
  before_action :set_print, only: [:show, :edit, :update, :destroy]  
  before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]
  
  
    # GET /prints
    # GET /prints.json
    def index
      @pdf = []
      @test = Test.find(params[:format])
      @test_questions = @test.questions
      answers = Answer.all
      @all_answers = answers.group_by(&:question_id)
      @test_questions.each do |q|
        @pdf << q
        @pdf += @all_answers[q.id]
      end
    end
    
    # GET /prints/1
    # GET /prints/1.json
    def show
    end
  
    # GET /prints/new
    def new
    end
    
    # GET /prints/1/edit
    def edit
    end
  
    # POST /prints
    # POST /prints.json
    def create
    end
  
    # PATCH/PUT /prints/1
    # PATCH/PUT /prints/1.json
    def update
    end
  
    # DELETE /prints/1
    # DELETE /prints/1.json
    def destroy
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_print
        @test = Test.find(params[:id])
        @question = Test.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def print_params
      end    
      
      # Before filters
      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

end