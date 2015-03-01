class CsvImportJob < ActiveJob::Base

  require 'csv'

  queue_as :default

  def perform(group, filepath)

    @group = group

    puts "Prepare to import #{filepath} ..."

    begin
      array = CSV.read(filepath, headers: true)

      #atualiza o numero de linhas que o grupo tem para importar
      group.update! import_number_lines: array.count

      array.each do |row|
        contact_hash = row.to_hash
        group.contacts.create!(contact_hash)
      end

      puts "Import #{filepath} completed"
    ensure
      #atualiza o grupo para terminado
      @group.ok!
      #envia a notificação para view do usuario usando o pusher
      Pusher[@group.user_id.to_s].trigger('import_group_done', {:status => 'success', :message => "O Grupo #{@group.name} está pronto!"})

      puts "Job completed with problems!"
    end


  end

  after_perform do |job|
    puts "Job completed!"
  end

end
