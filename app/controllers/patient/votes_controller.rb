class Patient::VotesController < Patient::BaseController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.patient_profile_id = current_user.profile.patient_profile.id
    if @vote.save
      clinics_homepages_path(@vote.clinic_profile_id)
    else
      clinics_homepages_path(@vote.clinic_profile_id)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:clinic_profile_id, :rate, :comment)
  end
end
