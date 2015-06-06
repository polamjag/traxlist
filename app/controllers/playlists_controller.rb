require 'csv'

class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:new, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.find(params[:id])
    #binding.pry
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    begin
      file = playlist_params[:upload_file]
      file_content = file.read
      pl =
        if file_content =~ /NML/
          # traktor nml
          Traktor::NML.parse(file_content).map do |t|
            {
              title: t[:title],
              artist: t[:artist],
              genre: t[:genre],
              label: t[:label],
              playtime: t[:playtime],
              bpm: t[:bpm]
            }
          end
        else
          # iTunes Playlist
          File.open file.tempfile.path, 'rb', encoding: Encoding::UTF_16LE do |f|
            csv = CSV.new f, encoding: Encoding::UTF_16LE, col_sep: "\t", row_sep: :auto
            csv_ar = csv.map do |tr|
              {
                title: tr[0],
                artist: tr[1],
                genre: tr[5],
                label: nil,
                playtime: tr[7],
                bpm: nil
              }
            end
            csv_ar.delete_at 0
            csv_ar
          end
        end
    rescue => e
    end
    @playlist = Playlist.new( tracks: pl, name: playlist_params[:name], description: playlist_params[:description] )
    @playlist.user = current_user
    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    if @playlist.user == current_user
      respond_to do |format|
        if @playlist.update(playlist_params)
          format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
          format.json { render :show, status: :ok, location: @playlist }
        else
          format.html { render :edit }
          format.json { render json: @playlist.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    if @playlist.user == current_user
      @playlist.destroy
      respond_to do |format|
        format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name, :description, :tracks, :upload_file)
    end
end
