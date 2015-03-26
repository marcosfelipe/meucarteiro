class MergeGroupsJob < ActiveJob::Base
  queue_as :default

  #mesclar grupos para o grupo
  def perform(group, groups)

    puts "Iniciando mescla de grupos"

    user = group.user

    groups.each do |g|

      if user.groups.exists?(g)
        group_copy = user.groups.find g
        group.contacts << group_copy.contacts
      end

    end

    Pusher[group.user_id.to_s].trigger('merge_groups_done', {:status => 'success', :message => "Contatos de vários grupos foram copiados para o grupo #{group.name} com sucesso!"})

    puts "Mescla de grupos concluida!"

  end


end
