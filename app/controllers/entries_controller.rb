class EntriesController < ApplicationController

	before_action :set_event, only: :update

  def update
  	@entry.update(entry_params)
  	redirect_to @entry.timeplan.event
  end

  private

  def entry_params
  	params.require(:entry).permit(:message, :attendance)
  	
  end

  def set_event
    @entry = Entry.find(params[:id])
  end

end
