class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, except: [:show, :past, :upcoming]

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @admin = User.first
    @meeting = Meeting.new
    redirect_to login_path unless @admin
    render :layout => 'admin'
  end

  # GET /meetings/1/edit
  def edit
  end

  # GET /meetings/past
  def past
    @meetings = Meeting.past.order('date DESC')
  end

  # GET /meetings/upcoming
  def upcoming
    @meetings = Meeting.upcoming.order('date ASC')
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to '/admin', notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { redirect_to '/admin', notice: 'Meeting invalid. Please try again.' }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    upcoming_or_past = Meeting.upcoming.include?(@meeting) ? 'upcoming' : 'past'

    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to "/meetings/#{upcoming_or_past}", notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:date, :time, :description)
    end

    def stringify_errors
      str = ""
    end
end
