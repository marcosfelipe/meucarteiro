class ContactMailer < ApplicationMailer


  def send_one(contact, from, subject, body)
    mail(to: contact.email, subject: subject, body: body, from: from)
  end



end