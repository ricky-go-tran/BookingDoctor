class ReMedicalMailer < ApplicationMailer
  layout 'mailer'
  def re_examination
    @medical_record = params[:medical]
    mail(to: 'developer.opendevzone@gmail.com', subject: 'DOCTORBOOKING! Notice of re-examination schedule')
  end
end
