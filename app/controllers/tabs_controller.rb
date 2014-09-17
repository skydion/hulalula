class TabsController < ApplicationController
  before_filter :check_authentic_user
  before_action :set_tab, only: [:show, :edit, :update, :destroy]

  # GET /tabs
  # GET /tabs.json
  def index
    @tabs = Tab.all
    @ticket_states = TicketState.all.to_a
  end

  # GET /tabs/1
  # GET /tabs/1.json
  def show
  end

  # GET /tabs/new
  def new
    @tab = Tab.new
    @ticket_states = TicketState.all.to_a
  end

  # GET /tabs/1/edit
  def edit
    @ticket_states = TicketState.all.to_a
  end

  # POST /tabs
  # POST /tabs.json
  def create
    @tab = Tab.new(tab_params)
    @tab.states = params[:tab][:states].delete_if(&:blank?)

    respond_to do |format|
      if @tab.save
        #format.html { redirect_to @tab, notice: 'Tab was successfully created.' }
        format.html { redirect_to tabs_path, notice: 'Tab was successfully created.' }
        format.json { render :show, status: :created, location: @tab }
      else
        format.html { render :new }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tabs/1
  # PATCH/PUT /tabs/1.json
  def update
    @tab.states = params[:tab][:states].delete_if(&:blank?)

    respond_to do |format|
      if @tab.update(tab_params)
        #format.html { redirect_to @tab, notice: 'Tab was successfully updated.' }
        format.html { redirect_to tabs_path, notice: 'Tab was successfully updated.' }
        format.json { render :show, status: :ok, location: @tab }
      else
        format.html { render :edit }
        format.json { render json: @tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabs/1
  # DELETE /tabs/1.json
  def destroy
    @tab.destroy
    respond_to do |format|
      format.html { redirect_to tabs_url, notice: 'Tab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params
      params.require(:tab).permit(:name, :show, :states) if params[:tab]
    end
end
