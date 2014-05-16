class TestsController < ApplicationController
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
      @test = Test.find(params[:id])
    end
  
    # GET /tests/new
    def new
      @test = Test.new
      #@build = @test.questions.new
    end
    
    # GET /tests/1/edit
    def edit
    end
  
    # POST /tests
    # POST /tests.json
    def create
      @test = Test.new(test_params)
      #@build = @test.questions.build(test_params)
      #Test.question_ids.create(:question_id => params[:test])
      respond_to do |format|
        if @test.save 
         #@test.attributes = {'question_ids' => []}.merge(params[:test] )
          #question = Test.last.questions
           #test = Test.last.id
          #@test.question_tests.update(question_id: question)
          format.html { redirect_to @test, notice: 'Test was successfully created.' }
          format.json { render action: 'show', status: :created, location: @test }
        else
          format.html { render action: 'new' }
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /tests/1
    # PATCH/PUT /tests/1.json
    def update
      @test.attributes = {'question_ids' => []}.merge(params[:test] || {})
      respond_to do |format|
        if @test.save
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
      @test.destroy
      respond_to do |format|
        format.html { redirect_to tests_url }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_test
        @question = Test.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def test_params
        params.require(:test).permit(:name, :user_id, :type, :category, :description, :question_ids => [], questions_attributes: [ :id ] ).
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