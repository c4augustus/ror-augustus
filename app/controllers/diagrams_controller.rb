class DiagramsController < ApplicationController
  before_action :set_diagram, only: [:show, :edit, :update, :destroy]

  @@diagram_new = Diagram.new

  # GET /diagrams
  # GET /diagrams.json
  def index
    @diagrams = Diagram.all.sort {|a,b| a.filename <=> b.filename}
    @diagram_new = @@diagram_new
  end

  # GET /diagrams/1
  # GET /diagrams/1.json
  def show
    @spec_content_diagram = spec_content_diagram
  end

  # GET /diagrams/new
  def new
    ## SCAFFOLD GENERATED ## @diagram = Diagram.new
  end

  # GET /diagrams/1/edit
  def edit
    index
    @diagram_edit = @diagram
    render action: 'index'
  end

  # POST /diagrams
  # POST /diagrams.json
  def create
    uploaded_file = params[:diagram][:file]
    if uploaded_file.nil?
      ### DISPLAY ERROR 
      redirect_to diagrams_path
      return
    end
    @diagram = Diagram.new diagram_params
    @diagram.filename = uploaded_file.original_filename 
    dirname_target = filepath_content_diagrams
    FileUtils.makedirs dirname_target
    File.open(filespec_content_diagram, 'wb') do |file|
      file.write uploaded_file.read
    end
    respond_to do |format|
      if @diagram.save
        ## SCAFFOLD GENERATED ## format.html { redirect_to @diagram, notice: 'Diagram was successfully created.' }
        format.html {}
        ## SCAFFOLD GENERATED ## format.json { render action: 'show', status: :created, location: @diagram }
        format.json {}
        redirect_to diagrams_path
      else
        format.html { render action: 'new' }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagrams/1
  # PATCH/PUT /diagrams/1.json
  def update
    respond_to do |format|
      if @diagram.update(diagram_params)
        format.html { redirect_to index, notice: 'Diagram was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagrams/1
  # DELETE /diagrams/1.json
  def destroy
    begin
      File.delete filespec_content_diagram
    rescue
    end
    @diagram.destroy
    respond_to do |format|
      format.html { redirect_to diagrams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagram
      @diagram = Diagram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagram_params
      params.require(:diagram).permit(:filename, :title, :revision, :revision_date, :width, :height)
    end

  def path_content_diagrams
    '/content/diagrams'
  end
  def spec_content_diagram
    path_content_diagrams + '/' + @diagram.filename
  end
  def filepath_content_diagrams
    (Rails.root.join 'public').to_s + path_content_diagrams
  end
  def filespec_content_diagram
    (Rails.root.join 'public').to_s + spec_content_diagram
  end
end
