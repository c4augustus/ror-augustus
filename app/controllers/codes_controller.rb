class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]

  @@code_new = Code.new

  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all.sort {|a,b| a.filename <=> b.filename}
    @code_new = @@code_new
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
    @spec_content_code = spec_content_code
  end

  # GET /codes/new
  def new
    ## SCAFFOLD GENERATED ## @code = Code.new
  end

  # GET /codes/1/edit
  def edit
    index
    @code_edit = @code
    render action: 'index'
  end

  # POST /codes
  # POST /codes.json
  def create
    uploaded_file = params[:code][:file]
    if uploaded_file.nil?
      ### DISPLAY ERROR 
      redirect_to codes_path
      return
    end
    @code = Code.new code_params
    @code.filename = uploaded_file.original_filename 
    dirname_target = filepath_content_codes
    FileUtils.makedirs dirname_target
    File.open(filespec_content_code, 'wb') do |file|
      file.write uploaded_file.read
    end
    respond_to do |format|
      if @code.save
        ## SCAFFOLD GENERATED ## format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.html {}
        ## SCAFFOLD GENERATED ## format.json { render action: 'show', status: :created, location: @code }
        format.json {}
        redirect_to codes_path
      else
        format.html { render action: 'new' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to index, notice: 'Code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    begin
      File.delete filespec_content_code
    rescue
    end
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:filename, :title, :revision, :revision_date, :width, :height)
    end

  def path_content_codes
    '/content/codes'
  end
  def spec_content_code
    path_content_codes + '/' + @code.filename
  end
  def filepath_content_codes
    (Rails.root.join 'public').to_s + path_content_codes
  end
  def filespec_content_code
    (Rails.root.join 'public').to_s + spec_content_code
  end
end
