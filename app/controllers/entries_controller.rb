class EntriesController < ApplicationController

	before_action :set_event, only: [:update, :btn]

  def index
    @entries = Entry.where(timeplan_id: params[:timeplan_id])
    render partial: 'list', locals: { entries: @entries }, layout: false
  end

  def update
  	@entry.update(entry_params)
  	render json: @entry
  end

  def btn
    render partial: 'attendance_modal', locals: { entry: @entry }, layout: false
  end

  private

  def entry_params
  	params.require(:entry).permit(:message, :attendance)
  end

  def set_event
    @entry = Entry.find(params[:id])
  end

end
