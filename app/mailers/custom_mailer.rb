class CustomMailer < ApplicationMailer
  default from: 'MyDomain <noreply@drikeda.net>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.custom_mailer.test.subject
  #
  def test
    @greeting = "Hi"

    mail to: "tentoutaisi@gmail.com"
  end
end
