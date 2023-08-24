class CanclePastAppointmentWorker
  include Sidekiq::Worker

  def perform(medical_record)
    medical_record = JSON.parse(medical_record)
    cancle_record = MedicalRecord.find(medical_record['id'])
    if cancle_record == 'appointment'
      cancle_record.status = 'cancle'
      cancle_record.save
    end
  end
end
