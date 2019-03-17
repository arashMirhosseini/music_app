class NotesController < ApplicationController

  def new
    # render "form"
  end

  def create
    params[:note][:user_id] = current_user.id
    @note = Note.new(note_params)
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if current_user.id != @note.user_id
      render status: :forbidden, text: "You can't detroy this comment"
    else
      @note.destroy
      redirect_to track_url(@note.track)
    end
  end

  private
  def note_params
    params.require("note").permit(:comment, :user_id, :track_id)
  end
end
