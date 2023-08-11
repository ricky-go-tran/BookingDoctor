class SendMailWorker
  include Sidekiq::Worker

  def perform(medical_record, clinic_profile, fullname, mail)
    ReMedicalMailer.with(medical: medical_record, clinic_profile:, fullname:, email: mail).re_examination.deliver_now
  end
end
