class Patient::VotesController < Patient::BaseController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.patient_profile_id = current_user.profile.patient_profile.id
    if @vote.save
      redirect_to "/clinics/#{@vote.clinic_profile_id}"
    else
      redirect_to "/clinics/#{@vote.clinic_profile_id}"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:clinic_profile_id, :rate, :comment)
  end
end
