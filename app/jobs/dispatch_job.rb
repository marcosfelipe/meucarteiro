class DispatchJob < ActiveJob::Base
  queue_as :default

  def perform(shipment)

    puts "Começando envio..."

    begin

      shipment.sending!

      sms_text = shipment.shipment_text.sms

      sms = SmsService.new

      shipment.shipment_contacts.each do |contact|

        sms.send_one contact.phone, "teste marcos"

      end

    ensure
      shipment.done!
      puts "Envio terminado!"
    end


  end
end
