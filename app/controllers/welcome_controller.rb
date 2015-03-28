class WelcomeController < ApplicationController

  layout :resolve_layout

  def index
  end

  def beta
  end

  private

  def resolve_layout
    case action_name
      when "index"
        "application"
      when "beta"
        "beta"
    end
  end

end
