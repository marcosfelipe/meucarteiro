class Granted::ImportsController < GrantedController

  def new
    @import = current_user.imports.new
  end

  def create
    @import = current_user.imports.new import_params[:import]
    if @import.save
      CsvImportJob.perform_later @import, import_group_params
      redirect_to contacts_path, notice: 'Lista de Contatos importada, em breve seus contatos estarão disponiveis!'
    else
      render action: :new
    end
  end

  private

  def import_params
    params.require(:import).permit({:import => [:separator, :file]}, {:group => {:ids => []}})
  end

  def import_group_params
    import_params.has_key?(:group) ? import_params[:group][:ids] : []
  end

end
