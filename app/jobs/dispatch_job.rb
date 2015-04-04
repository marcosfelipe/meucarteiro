class DispatchJob < ActiveJob::Base
  queue_as :low

  def perform(shipment)

    puts "Começando envio..."

    begin

      shipment.sending!

      sms_text = shipment.shipment_text.sms
      whatsapp_text = shipment.shipment_text.whatsapp
      email = shipment.shipment_email

      sms = SmsService.new
      whatsapp = WhatsappService.new

      #todo paginacao para envio, enviar pela api de 10 em 10

      shipment.shipment_contacts.each do |contact|

        #response = sms.send_one contact.phone, sms_text
        #puts response

        #response = whatsapp.send_one contact.phone, whatsapp_text
        #puts response

        puts "# mandando email para #{contact.name}"
        ContactMailer.send_one(contact, email.from, email.subject, email.body).deliver_later

      end

    ensure
      shipment.done!
      puts "Envio terminado!"
    end


  end
end
