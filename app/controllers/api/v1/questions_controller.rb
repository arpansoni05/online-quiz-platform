class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :find_question, only: [:show, :update, :destroy]
  before_action :find_questions, only: [:index, :create]

#======================================================================
        # GET /api/v1/assessments/:assessment_id/questions/
#======================================================================

  def index
    @questions = @assessment_id
    render json: @questions
  end

#======================================================================================
        # GET /api/v1/assessments/:assessment_id/questions/:question_id
#======================================================================================

  def show
    render json: @question
  end

# #======================================================================================
#         # POST /api/v1/assessments/:assessment_id/questions/
# #======================================================================================

  def create
    @question = @assessment_id.new(question_params)
    if @question.save
      render json: @question, status: :created
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

#==============================================================================================
        # PATCH /api/v1/assessments/:assessment_id/questions/:question_id
#==============================================================================================
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

# #==============================================================================================
#         # DELETE /api/v1/assessments/:assessment_id/questions/:question_id
# #==============================================================================================

  def destroy
    if @question.destroy
      render json: { data: "question destroyed successfully" }
    else
      render json: { error: "Failed to destroy question" }
    end
  end

  private
  def find_questions
    @assessment_id = Assessment.find(params[:assessment_id]).questions
  end

  def find_question
    @question = Assessment.find(params[:assessment_id]).questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :number_of_options)
  end
end








# def index
#   @coding_questions = CodingQuestion.all
# end

# def create
#   @coding_question = CodingQuestion.new(coding_question_params)
#   if @coding_question.save
#     render json: @coding_question
#   else
#     render json: {error: @coding_question.errors.full_messages }
#   end
# end

# private

# def coding_question_params
#   params.require(:coding_question).permit(:content, :answer, :test1, :test2, :test3)
# end
# end
