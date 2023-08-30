class Patient::VotesController < Patient::BaseController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.patient_profile_id = current_user.profile.patient_profile.id
    if @vote.save
      flash[:success_notice] = I18n.t('rate.basic.create_success')
    else
      flash[:error_notice] = I18n.t('rate.basic.create_error')
    end
    redirect_to clinics_homepage_path(@vote.clinic_profile_id)
  end

  private

  def vote_params
    params.require(:vote).permit(:clinic_profile_id, :rate, :comment)
  end
end
