class Api::V1::AllocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_id, only: [:show,:destroy]


#====================================================
        # GET /api/v1/allocations
#====================================================

  def index
    @allocations = Allocation.all
    render json: @allocations
  end

#====================================================
        # GET /api/v1/allocations/:allocation_id
#====================================================

  def show
    render json: @allocation
  end

#====================================================
        # POST /api/v1/allocations
#====================================================
  def create
    @allocation = Allocation.new(allocation_params)
  # rescue ArgumentError => e
  #   render json: {error: e.message}
    if @allocation.save
      render json: @allocation
    else
      render json: {error: @allocation.errors.full_messages}
    end
  end

#====================================================
        # DEL /api/v1/allocations/allocation_id
#====================================================

  def destroy
    if @allocation.destroy
      render json: @allocation
    else
      render json: {error: @allocation.errors.full_messages}
    end
  end

#====================================================
        # GET /api/v1/assessments/:assessment_id/take
#====================================================

  def take
    assessment = Assessment.find(params[:assessment_id])
    render json: take_assessment(assessment)
  end
#====================================================
  # POST   /api/v1/assessments/:assessment_id/submit
#====================================================

  def submit
    @questions = Assessment.find(params[:assessment_id]).questions
    user_id = current_user.id
    allocation = Allocation.find_or_initialize_by(user_id: user_id, assessment_id: params[:assessment_id])
    if allocation.status == "registered"
      render json: submit_assessment(@questions, user_id, allocation)
    else
      "error: not registered"
    end
  end


  private

  def submit_assessment(questions, user_id, allocation)
    score = 0
    option_select = params[:answers]
    questions.each_with_index do |question, i|
      correct_option = question.answers.find_by(correct: true)&.content
      if correct_option == option_select[i]
        score += 1
      end
    end
    allocation.score = score
    allocation.save
    "score : #{score}"
  end

  def take_assessment(assessment)
    data = {}
    questions = assessment.questions
    data["assessment"] = {
      assessment_id:  assessment.id,
      title:  assessment.title,
      total_mcqs_questions: assessment.total_mcqs_questions,
      questions:questions.map do |question|
        { question: question.content,
          answers: question.answers.map do |answer|
            { option: answer.content }
          end
        }
      end
    }
  end

  def find_id
    @allocation = Allocation.find(params[:id])
  end

  def allocation_params
    params.require(:allocation).permit(:user_id, :assessment_id)
  end
end
