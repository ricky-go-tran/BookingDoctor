class SendmailerJob
  include Sidekiq::Job
  def perform(medical_record, mail)
    ReMedicalMailer.with(medical: medical_record, email: mail).re_examination.deliver_now
  end
end
