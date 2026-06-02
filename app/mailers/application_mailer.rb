class ApplicationMailer < ActionMailer::Base
  default from: "23tkik24u@mozmail.com" # Sử dụng email đã xác thực với Mailjet
  layout "mailer"
end
