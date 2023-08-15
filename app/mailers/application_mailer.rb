# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'developer.opendevzone@gmail.com'
  layout 'mailer'
end
