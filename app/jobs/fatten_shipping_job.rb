#cria os contatos para a remessa

class FattenShippingJob < ActiveJob::Base
  queue_as :default

  #shipment active record
  #group_ids array
  def perform(shipment, group_ids)

    user = shipment.user

    #fattening shipment
    shipment.fattening!

    begin
      puts "Fattening #{shipment.name} ..."

      #faz um array de grupos validos do usuario
      groups = []
      group_ids.each do |g|
        if user.groups.exists?(g)
          groups.push Group.find(g)
        end
      end if group_ids.length > 0

      groups.each do |gr|

        gr.contacts.each do |contact|

          new_shipment_contact = shipment.shipment_contacts.new
          new_shipment_contact.name = contact.name
          new_shipment_contact.email = contact.email
          new_shipment_contact.phone = contact.phone
          new_shipment_contact.facebook = contact.facebook
          new_shipment_contact.save!

        end if gr.contacts.size > 0

      end if groups.size > 0
    ensure
      #remessa com status pronto
      shipment.ready!
      puts "Remessa pronta para envio!"

      DispatchJob.perform_later shipment

    end

  end

end
