class GroupContact < ActiveRecord::Base

  belongs_to :group
  belongs_to :contact



  #importa um arquivo de contatos para um grupo
  def self.import(group, file)
    #chama a queue para rodar em backgroud  a importação
    CsvImportJob.perform_later(group, file.path)
  end

end
