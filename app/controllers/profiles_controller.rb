class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :fetch_profile_by_id, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    redirect_to @profile, notice: t('.success') if @profile.update(profile_params)
  end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :bio, :country, :birth_date)
  end

  def fetch_profile_by_id
    @profile = Profile.find(params[:id])
  end
end
