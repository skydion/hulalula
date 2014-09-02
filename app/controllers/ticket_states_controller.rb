class TicketStatesController < ApplicationController
  before_action :set_ticket_state, only: [:show, :edit, :update, :destroy]

  # GET /ticket_states
  # GET /ticket_states.json
  def index
    @ticket_states = TicketState.all
  end

  # GET /ticket_states/1
  # GET /ticket_states/1.json
  def show
  end

  # GET /ticket_states/new
  def new
    @ticket_state = TicketState.new
  end

  # GET /ticket_states/1/edit
  def edit
  end

  # POST /ticket_states
  # POST /ticket_states.json
  def create
    @ticket_state = TicketState.new(ticket_state_params)

    respond_to do |format|
      if @ticket_state.save
        #format.html { redirect_to @ticket_state, notice: 'Ticket state was successfully created.' }
        format.html { redirect_to ticket_states_path, notice: 'Ticket state was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_state }
      else
        format.html { render :new }
        format.json { render json: @ticket_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_states/1
  # PATCH/PUT /ticket_states/1.json
  def update
    respond_to do |format|
      if @ticket_state.update(ticket_state_params)
        format.html { redirect_to ticket_states_path, notice: 'Ticket state was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_state }
      else
        format.html { render :edit }
        format.json { render json: @ticket_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_states/1
  # DELETE /ticket_states/1.json
  def destroy
    @ticket_state.destroy
    respond_to do |format|
      format.html { redirect_to ticket_states_url, notice: 'Ticket state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_state
      @ticket_state = TicketState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_state_params
      params.require(:ticket_state).permit(:name) if params[:ticket_state]
    end
end
