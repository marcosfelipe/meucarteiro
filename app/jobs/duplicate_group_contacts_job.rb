class DuplicateGroupContactsJob < ActiveJob::Base
  queue_as :default


  #group1 é o grupo que vai receber os contatos do grupo2
  def perform(group, group_to_dup)

    puts "Iniciando duplicação:"

    begin

      puts "Começando a duplicar contatos do grupo #{group_to_dup.name}"

      if group_to_dup.contacts.count > 0

        #fazendo associação dos contatos do group_to_dup para o novo grupo
        group.contacts << group_to_dup.contacts

        puts "Terminado de duplicar contatos do grupo #{group_to_dup.name}"

      else
        puts "Nenhum contato encontrado no grupo #{group_to_dup.name}"
      end

      Pusher[group.user_id.to_s].trigger('duplicate_group_done', {:status => 'success', :message => "Contatos do grupo #{group_to_dup.name} foram copiados para o grupo #{group.name} com sucesso!"})

    rescue

      puts "Erro ao tentar duplicar o grupo #{group_to_dup.name}"
      Pusher[group.user_id.to_s].trigger('duplicate_group_done', {:status => 'error', :message => "Aconteceu erro ao tentar copiar contatos do grupo #{group_to_dup.name} para o grupo #{group.name}!"})

    end


  end

end
