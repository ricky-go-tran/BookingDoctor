class Patient::VotesController < Patient::BaseController
  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.patient_profile_id = current_user.profile.patient_profile.id
    if @vote.save
      flash[:success_notice] = 'Success! Votes is successed'
    else
      flash[:error_notice] = 'Error! Votes is failed'
    end
    redirect_to "/clinics/#{@vote.clinic_profile_id}"
  end

  private

  def vote_params
    params.require(:vote).permit(:clinic_profile_id, :rate, :comment)
  end
end
