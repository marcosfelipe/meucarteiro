class CsvImportJob < ActiveJob::Base

  require 'csv'

  queue_as :default

  def perform(group, filepath)

    @group = group

    puts "Prepare to import #{filepath} ..."

    @new_import = Import.create! user_id: group.user_id

    begin
      array = CSV.read(filepath, headers: true)

      #atualiza o numero de linhas de contatos para importar
      @new_import.update! contacts_count: array.count

      #hash de colunas dos contatos
      contacts_columns = Contact.column_names.reject{|key| key=="id"}

      array.each_with_index do |row, row_n|

        #verifica se a chave da coluna do csv é uma coluna na tabela
        row = row.to_hash
        row.select! do |key,_|
          contacts_columns.include? key
        end

        contact = Contact.new row
        contact.user_id = @group.user_id
        if contact.valid?
          group.contacts << contact
        else
          contact.errors.full_messages.each do |message|
            error = "Um problema ocorreu na linha #{row_n+1}, #{message}"
            @new_import.import_infos.create! message: error
            puts error
          end
        end

      end

      puts "Import #{filepath} completed"
    ensure
      #atualiza a importação para terminado
      @new_import.done!
      #envia a notificação para view do usuario usando o pusher
      Pusher[@group.user_id.to_s].trigger('import_group_done', {:status => 'success', :message => "O Grupo #{@group.name} está pronto!"})

      puts "Job completed with problems!"
    end


  end

  after_perform do |job|
    puts "Job completed!"
  end

end
