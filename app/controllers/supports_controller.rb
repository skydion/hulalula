class SupportsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :index, :authenticate ]

  def new
    @support = Support.new
    @roles = Role.all
  end

  def edit
    @support = Support.find(params[:id])
    @roles = Role.all
  end

  def update
    @support = Support.find(params[:id])

    if @support.update(support_params)
      session[:role_name] = Role.find_by(id: @support.role_id).name
      redirect_to supports_path, notice: 'Support user was successfully updated.'
    else
      render 'edit'
    end
  end

  def create
    @support = Support.new(support_params)
    @support.update_attribute :role_id, params[:selected_role]

    if @support.save
      redirect_to supports_path, notice: 'Support user was successfully created.'
    else
      render 'new'
    end
  end

  def show
    #@support = Support.find(params[:id])
  end

  def index
    @roles = Role.all
    @supports = Support.all
  end

  def destroy
    @support = Support.find(params[:id])
    @support.destroy

    redirect_to supports_path
  end

  def logout
    reset_session
    redirect_to :controller => 'application', :action => 'index'
  end

  def authenticate
      @support = Support.new(login: params[:support][:login], password: params[:support][:password])
      valid = @support.check_login

      if valid.nil?
        redirect_to :controller => 'application', :action => 'index', :alert => 'Invalid Login or Password, check it and try again'
      else
        session[:user_id] = valid.id
        session[:login] = valid.login
        session[:role_name] = Role.find_by(id: valid.role_id).name

        redirect_to :controller => 'tickets', :action => 'index'
      end
  end

private
  def support_params
    params.require(:support).permit(:login, :password, :first_name, :last_name, :email, :role_id) if params[:support]
  end
end

