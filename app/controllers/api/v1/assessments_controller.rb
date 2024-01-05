class Api::V1::AssessmentsController < ApiController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :authenticate_user!, only: [:create, :index, :destroy, :update, :assign_assessments]

  before_action :set_find, only: [:show, :update, :destroy]


#======================================================================
        # GET /api/v1/assessments
#======================================================================

  def index
    @assessments = Assessment.where(user_id: current_user.id)
    render json: @assessments
  end


#======================================================================
        # GET /api/v1/assessments/:id
#======================================================================
  def show
    render json: @assessment
  end

#======================================================================
        # POST /api/v1/assessments/
#======================================================================

  def create

    @assessment = current_user.assessments.new(assessment_params)
    # byebug
    # user_id = current_user.id
    if @assessment.save
      # byebug
      # Allocation.last.update(status: "created")
      render json: @assessment
    else
      render json: {error: @assessment.errors.full_messages}
    end
  end


#======================================================================
        # PATCH /api/v1/assessments/:id
#======================================================================

  def update
    if @assessment.update(assessment_params)
      render json: @assessment
    else
      render json: {error: @assessments.errors.full_messages}
    end
  end


#======================================================================
        # DELETE /api/v1/assessments/:id
#======================================================================

  def destroy
    if @assessment.destroy
      render json: { data: "Assessment destroyed successfully" }
    else
      render json: { error: "Failed to destroy assessment" }
    end
  end

#======================================================================
        # POST /api/v1/assessments/:assessment_id/assign_assessments
#======================================================================

  def assign_assessments
    assessment_id = Assessment.find(params[:assessment_id])
    @assessment = assessment_id.allocations.new
    @assessment.user_id = current_user.id
    @assessment.assessment_id = assessment_id.id
    if @assessment.save
      @assessment = assessment_id.allocations.update(status: 'registered')
      render json: @assessment
    else
      render json: {error: @assessment.errors.full_messages}
    end
  end

#======================================================================
        # GET /api/v1/show_assign_assessments
#======================================================================

  def show_assign_assessments
    @assessments = Assessment.all
    render json: assigned_assessments_data(@assessments)
  end

  private

  def assigned_assessments_data(assessments)
    data = {}
    # byebug
    data["assessments"] = assessments.map do |assessment|
      {
        assessment_id:  assessment.id,
        title:  assessment.title,
        total_mcqs_questions: assessment.total_mcqs_questions
      }
    end
  end

  def set_find
    @assessment = Assessment.find(params[:id])
  end

  def assessment_params
    params.require(:assessment).permit(:title, :duration_minutes, :total_mcqs_questions, :user_id)
  end

end
