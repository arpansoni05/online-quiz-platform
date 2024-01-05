class Api::V1::AnswersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :find_answer, only: [:update, :destroy]
  before_action :find_answers, only: [:index, :create]

#======================================================================================
        # GET /api/v1/assessments/:assessment_id/questions/:question_id/answers
#======================================================================================

 def index
  @answers = @question_id
  render json: @answers
 end

 def show
  render json: @answer
 end

# #======================================================================================
#         # POST /api/v1/assessments/:assessment_id/questions/:question_id/answers/
# #======================================================================================

 def create
  # byebug
  if answer_params[:correct].instance_of?(TrueClass) || answer_params[:correct].instance_of?(FalseClass)
    @answer = @question_id.new(answer_params)
    if @answer.save
      render json: @answer
    else
      render json: {error: @answer.errors.full_messages }
    end
  else
    render json: {error: "Correct must be boolean" }
  end
 end

#==============================================================================================
        # PATCH /api/v1/assessments/:assessment_id/questions/:question_id/answers/:answer_id
#==============================================================================================

  def update

    if @answer.update(answer_params)
      # byebug
      render json: @answer
    else
      render json: {error: @answer.errors.full_messages }
    end
  end


# #==============================================================================================
#         # DELETE /api/v1/assessments/:assessment_id/questions/:question_id/answers/:answer_id
# #==============================================================================================

  def destroy
    # byebug
    if @answer.destroy
      render json: { data: "answer destroyed successfully" }
    else
      render json: {error: @answer.errors.full_messages }
    end
  end

  private

  def find_answers
    @question_id = Assessment.find(params[:assessment_id]).questions.find(params[:question_id]).answers
  end

  def find_answer
    @answer = Assessment.find(params[:assessment_id]).questions.find(params[:question_id]).answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content, :correct, :number_of_options)
  end
end
