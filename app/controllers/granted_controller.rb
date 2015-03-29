class GrantedController < ApplicationController

  before_action :authenticate_user!

  before_action :set_locale

  def set_locale
    I18n.locale = current_user.language.locale
    #I18n.locale = params[:locale] || current_user.language.locale || I18n.default_locale
  end


  layout "granted"

end
