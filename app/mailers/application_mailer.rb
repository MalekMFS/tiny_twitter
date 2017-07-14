class ApplicationMailer < ActionMailer::Base
  default from: "noreply@meam.ir"
  #TODO replace domain above
  layout 'mailer'
end
