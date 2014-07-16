class SupportsController < ApplicationController
  before_filter :check_authentic_user, :except =>[ :index, :authenticate ]

  def new
    @support = Support.new
  end

  def edit
    @support = Support.find(params[:id])
  end

  def update
    @support = Support.find(params[:id])

    if @support.update(support_params)
      redirect_to @support
    else
      render 'edit'
    end
  end

  def create
    @support = Support.new(support_params)
    @support.update_attribute :role_id, params[:selected_role]

    if @support.save
      flash[:notice] = 'User was successfully created.'
      redirect_to @support
    else
      render 'new'
    end
  end

  def show
    @support = Support.find(params[:id])
  end

  def index
    @supports = Support.all
  end

  def destroy
    @support = Support.find(params[:id])
    @support.destroy

    redirect_to supports_path
  end

  def logout
    reset_session
    redirect_to :controller => 'welcome', :action => 'index'
  end

  def authenticate
    if request.get?
      render :action=> 'index'
    else
      l = params[:supports][:username]
      p = params[:supports][:password]
      puts '=== login: ' + l + ' password: ' + p

      @support = Support.new(login: l, password: p)
      valid = @support.check_login

      if !valid.nil?
        session[:user_id] = valid.id
        session[:login] = valid.login
        puts '=== id: ' + valid.id.to_s
        puts '=== Welcome ' + valid.login
        redirect_to :controller => 'tickets', :action => 'index'
      else
        puts '=== Invalid User/Password'
        redirect_to :controller => 'welcome', :action => 'index'
      end
    end
  end

private
  def support_params
    params.require(:support).permit(:login, :password, :first_name, :last_name, :email)
  end
end

