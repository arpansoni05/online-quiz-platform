class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "You are not authorized to access this page." }
  end

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
