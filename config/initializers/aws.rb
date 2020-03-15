ActionMailer::Base.add_delivery_method :ses,
                                       AWS::SES::Base,
                                       access_key_id: ENV['SMTP_USER'],
                                       secret_access_key: ENV['SMTP_PASS'],
                                       server: 'email-smtp.us-west-2.amazonaws.com'