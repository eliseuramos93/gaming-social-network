class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :fetch_profile_by_id, only: %i[show edit update]
  before_action :redirect_unauthorized_user, only: %i[edit update]

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

  def redirect_unauthorized_user
    redirect_to root_path, alert: t('alerts.unauthorized') unless current_user.profile == @profile
  end
end
