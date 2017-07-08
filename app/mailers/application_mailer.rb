class ApplicationMailer < ActionMailer::Base
  default from: "noreply@example.com"
  #TODO replace domain above
  layout 'mailer'
end
