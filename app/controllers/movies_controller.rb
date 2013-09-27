class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  @@movie_new = Movie.new

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all.sort {|a,b| a.filename <=> b.filename}
    @movie_new = @@movie_new
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @spec_content_movie = spec_content_movie
  end

  # GET /movies/new
  def new
    ## SCAFFOLD GENERATED ## @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    index
    @movie_edit = @movie
    render action: 'index'
  end

  # POST /movies
  # POST /movies.json
  def create
    uploaded_file = params[:movie][:file]
    if uploaded_file.nil?
      ### DISPLAY ERROR 
      redirect_to movies_path
      return
    end
    @movie = Movie.new movie_params
    @movie.filename = uploaded_file.original_filename 
    dirname_target = filepath_content_movies
    FileUtils.makedirs dirname_target
    File.open(filespec_content_movie, 'wb') do |file|
      file.write uploaded_file.read
    end
    respond_to do |format|
      if @movie.save
        ## SCAFFOLD GENERATED ## format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.html {}
        ## SCAFFOLD GENERATED ## format.json { render action: 'show', status: :created, location: @movie }
        format.json {}
        redirect_to movies_path
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to index, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    begin
      File.delete filespec_content_movie
    rescue
    end
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:filename, :title, :revision, :revision_date, :width, :height)
    end

  def path_content_movies
    '/content/movies'
  end
  def spec_content_movie
    path_content_movies + '/' + @movie.filename
  end
  def filepath_content_movies
    (Rails.root.join 'public').to_s + path_content_movies
  end
  def filespec_content_movie
    (Rails.root.join 'public').to_s + spec_content_movie
  end
end
