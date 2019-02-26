class ApplicationController < ActionController::API
  include ActionView::Rendering
  include ActionController::ImplicitRender
  include ActionView::Layouts
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
        errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors
            }
        ]
    }, status: :bad_request
  end
end
