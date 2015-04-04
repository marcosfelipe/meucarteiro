class ApplicationMailer < ActionMailer::Base

  # todo: from deve ser configuração do usuario
  default from: "user.config@user.config.com"
  layout 'mailer'

end