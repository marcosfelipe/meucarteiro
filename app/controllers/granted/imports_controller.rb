class Granted::ImportsController < GrantedController

  def index
    @imports = current_user.imports.all.page(params[:page]).per(15)

  end


end
