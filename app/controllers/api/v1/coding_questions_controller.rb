class Api::V1::CodingQuestionsController < ApplicationController
  # before_action :authenticate_user!
  # load_and_authorize_resource
  before_action :find_question, only: [:show, :update, :destroy]
  before_action :find_assessment, only: [:index, :create]


#======================================================================
        # GET /api/v1/assessments/:assessment_id/coding_questions/
#======================================================================

  def index
    @coding_questions = CodingQuestion.all
    render json: @coding_questions
  end

#=================================================================================================
        # GET /api/v1/assessments/:assessment_id/coding_questions/:coding_questions_id
#=================================================================================================

  def show
    render json: @coding_question
  end

#===========================================================================
        # POST /api/v1/assessments/:assessment_id/coding_questions
#===========================================================================

  def create
    @coding_question = @assessment_id.new(coding_question_params)
    # byebug
    if @coding_question.save
      byebug
      render json: @coding_question
    else
      render json: {errors: @coding_question.errors.full_messages } , status: :unprocessable_entity
    end
  end

#=================================================================================================
        # PATCH /api/v1/assessments/:assessment_id/coding_questions/:coding_questions_id
#=================================================================================================

  def update
    if @coding_question.update(coding_question_params)
      render json: @coding_question
    else
      render json: { errors: @coding_question.errors.full_messages }, status: :unprocessable_entity
    end
  end


#=================================================================================================
        # DELETE /api/v1/assessments/:assessment_id/coding_questions/:coding_questions_id
#=================================================================================================

  def destroy
    if @coding_question.destroy
      render json: { data: "question destroyed successfully" }
    else
      render json: { error: "Failed to destroy question" }
    end
  end

  # def compile
  #   compiler_service = CompilerService.new(ENV['REPLIT_API_KEY'])
  #   language = params[:language]
  #   code = params[:code]

  #   result = compiler_service.compile_code(language, code)

  #   render json: { result: result }
  # end

  private

  def find_assessment
    @assessment_id = Assessment.find(params[:assessment_id]).coding_questions
  end

  def find_question
    @question = Assessment.find(params[:assessment_id]).coding_questions.find(params[:id])
  end

  def coding_question_params
    params.require(:coding_question).permit(:content, :answer, :test1, :test2, :test3)
  end
end
