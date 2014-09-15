class SupportsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :authenticate ]

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
    @roles = Role.all

    if params[:support].has_key?(:password_confirmation)
      if params[:support][:password] != params[:support][:password_confirmation]
        flash[:alert] = 'Password did not match.'
        render 'change_password'
        return
      end
    end

    if @support.update(support_params)
      flash[:notice] = 'Support user was successfully updated.'
      if session[:role_name] == 'admin'
        redirect_to supports_path
      else
        redirect_to edit_support_path
      end
    else
      render 'edit'
    end
  end

  def create
    @support = Support.new(support_params)
    #@support.update_attribute :role_id, params[:selected_role]
    @support.role_id = params[:selected_role]

    if @support.save
      flash[:notice] = 'Support user was successfully created.'
      redirect_to supports_path
    else
      render 'new'
    end
  end

  def show
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
    redirect_to :controller => 'application'
  end

  def authenticate
      @support = Support.new(login: params[:support][:login], password: params[:support][:password])
      valid = @support.check_login

      if valid.nil?
        flash[:alert] = 'Invalid Login or Password, check it and try again.'
        redirect_to :controller => 'application'
      else
        session[:user_id] = valid.id
        session[:login] = valid.login
        session[:role_name] = Role.find_by(id: valid.role_id).name

        redirect_to :controller => 'tickets'
      end
  end

  def change_password
    @support = Support.find(params[:id])
  end

private
  def support_params
    params.require(:support).permit(:login, :password, :first_name, :last_name, :email, :role_id) if params[:support]
  end
end
