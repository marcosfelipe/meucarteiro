class CsvImportJob < ActiveJob::Base

  require 'csv'

  queue_as :default

  #import active record
  #groups_ids array
  def perform(import, group_ids)

    filepath = import.file.current_path
    user = import.user

    puts "Prepare to import #{filepath} ..."

    #faz um array de grupos validos do usuario
    groups = []
    group_ids.each do |g|
      if user.groups.exists?(g)
        groups.push Group.find(g)
      end
    end if group_ids.length > 0

    begin
      #le todas as linhas do csv
      lines = CSV.read filepath, headers: true, col_sep: import.separator

      #atualiza o numero de linhas de contatos para importar
      import.update! contacts_count: lines.count

      #hash de colunas dos contatos
      contacts_columns = Contact.column_names.reject{|key| key=="id"}

      lines.each_with_index do |row, row_n|

        #verifica se a chave da coluna do csv é uma coluna na tabela
        row = row.to_hash
        row.select! do |key,_|
          contacts_columns.include? key
        end

        contact = Contact.new row
        contact.user_id = import.user_id
        if contact.valid?
          #se tem grupos para por os contatos
          if groups.size > 0
            groups.each do |group|
              group.contacts << contact
            end
          else
            #para os contatos do usuario
            user.contacts << contact
          end
        else
          #escreve os erros no import_infos caso o contato não seja valido
          contact.errors.full_messages.each do |message|
            error = "Um problema ocorreu na linha #{row_n+1}, #{message}"
            import.import_infos.create! message: error
            puts error
          end
        end
      end

      puts "Import #{filepath} completed"
    ensure
      #atualiza a importação para terminado
      import.done!
      #envia a notificação para view do usuario usando o pusher
      Pusher[user.id.to_s].trigger('import_group_done', {:status => 'success', :message => "A importação do arquivo #{import.file.identifier} está pronto!"})

      puts "Job completed with problems!"
    end


  end

  after_perform do |job|
    puts "Job completed!"
  end

end
