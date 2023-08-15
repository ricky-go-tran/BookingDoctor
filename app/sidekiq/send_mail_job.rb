class SendMailJob < ActiveJob::Base
  def perform(medical_record, mail)
    ReMedicalMailer.with(medical: medical_record, email: mail).re_examination.deliver_now
  end
end
