class WelcomeController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :index ]

  def index
  end
end
