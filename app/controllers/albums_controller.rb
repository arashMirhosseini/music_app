class AlbumsController < ApplicationController

  before_action :logged_in_user!

  def show
    #/albums/:id
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      render json: "Couldn\'t find"
    else
      render :show
    end
  end

  def new
    #/bands/:band_id/albums/new
    @band = Band.find_by(id: params[:band_id])
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def create
    # POST:  /albums
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      # render json: flash.now[:errors]
      @band = @album.band
      @bands = Band.all
      render :new
      # redirect_to new_band_album_url(@album.band)
      # render json: "not saved"
    end
  end

  def edit
    # /albums/:id/edit
    @album = find_by(id: params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    # PATCH: /albums/:id
    @album = find_by(id: params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    # DELETE: /albums/:id
    @album = Album.find_by(id: params[:id])
    if @album.destroy
      redirect_to band_url(@album.band)
    else
      redner json: "Couldn\'t destroy"
    end
  end

  private
  def album_params
    params.require("album").permit(:title, :year, :band_id, :kind)
  end

end
