class ReMedicalMailer < ApplicationMailer
  layout 'mailer'
  def re_examination
    @medical_record = JSON.parse(params[:medical])
    @clinic_profile = JSON.parse(params[:clinic_profile])
    @fullname = params[:fullname]
    @email = params[:email]
    mail(to: @email, subject: 'DOCTORBOOKING! Notice of re-examination schedule')
  end
end
