class GrantedController < ApplicationController

  before_action :authenticate_user!


  layout "granted"


end
