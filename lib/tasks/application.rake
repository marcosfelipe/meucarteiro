namespace :application do

  desc "inserir linguagens na tabela languages"
  task languages: :environment do

    Language.destroy_all

    Language.create! :locale => 'pt', :id => 1
    puts '# inseriu linguagem pt'
    Language.create! :locale => 'en', :id => 2
    puts '# inseriu linguagem en'

  end

end
