class WritingsController < ApplicationController
  before_action :set_writing, only: [:show, :edit, :update, :destroy]

  @@writing_new = Writing.new

  # GET /writings
  # GET /writings.json
  def index
    @writings = Writing.all.sort {|a,b| a.filename <=> b.filename}
    @writing_new = @@writing_new
  end

  # GET /writings/1
  # GET /writings/1.json
  def show
    @spec_content_writing = spec_content_writing
  end

  # GET /writings/new
  def new
    ## SCAFFOLD GENERATED ## @writing = Writing.new
  end

  # GET /writings/1/edit
  def edit
    index
    @writing_edit = @writing
    render action: 'index'
  end

  # POST /writings
  # POST /writings.json
  def create
    uploaded_file = params[:writing][:file]
    if uploaded_file.nil?
      ### DISPLAY ERROR 
      redirect_to writings_path
      return
    end
    @writing = Writing.new writing_params
    @writing.filename = uploaded_file.original_filename 
    dirname_target = filepath_content_writings
    FileUtils.makedirs dirname_target
    File.open(filespec_content_writing, 'wb') do |file|
      file.write uploaded_file.read
    end
    respond_to do |format|
      if @writing.save
        ## SCAFFOLD GENERATED ## format.html { redirect_to @writing, notice: 'Writing was successfully created.' }
        format.html {}
        ## SCAFFOLD GENERATED ## format.json { render action: 'show', status: :created, location: @writing }
        format.json {}
        redirect_to writings_path
      else
        format.html { render action: 'new' }
        format.json { render json: @writing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /writings/1
  # PATCH/PUT /writings/1.json
  def update
    respond_to do |format|
      if @writing.update(writing_params)
        format.html { redirect_to index, notice: 'Writing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @writing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /writings/1
  # DELETE /writings/1.json
  def destroy
    begin
      File.delete filespec_content_writing
    rescue
    end
    @writing.destroy
    respond_to do |format|
      format.html { redirect_to writings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_writing
      @writing = Writing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def writing_params
      params.require(:writing).permit(:filename, :title, :revision, :revision_date, :width, :height)
    end

  def path_content_writings
    '/content/writings'
  end
  def spec_content_writing
    path_content_writings + '/' + @writing.filename
  end
  def filepath_content_writings
    (Rails.root.join 'public').to_s + path_content_writings
  end
  def filespec_content_writing
    (Rails.root.join 'public').to_s + spec_content_writing
  end
end
