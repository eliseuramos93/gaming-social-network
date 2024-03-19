class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def show
    @profile = Profile.find(params[:id])
  end
end
