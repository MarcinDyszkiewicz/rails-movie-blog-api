class Api::V1::TagController < ApplicationController


  private
  # post strong params
  # @return [Object]
  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
