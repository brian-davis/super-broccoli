# frozen_string_literal: true

# ApplicationMailer is an abstract class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
