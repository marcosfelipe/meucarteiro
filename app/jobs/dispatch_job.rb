class DispatchJob < ActiveJob::Base
  queue_as :default

  def perform(shipment)

    puts "Começando envio..."

    begin

      shipment.sending!

      sms_text = shipment.shipment_text.sms
      whatsapp_text = shipment.shipment_text.whatsapp

      sms = SmsService.new
      whatsapp = WhatsappService.new

      shipment.shipment_contacts.each do |contact|

        #response = sms.send_one contact.phone, sms_text
        #puts response

        response = whatsapp.send_one contact.phone, whatsapp_text
        puts response

      end

    ensure
      shipment.done!
      puts "Envio terminado!"
    end


  end
end
