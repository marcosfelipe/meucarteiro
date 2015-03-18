class Granted::ImportsController < GrantedController

  def index
    @imports = Import.all

  end
end
