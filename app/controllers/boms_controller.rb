class BomsController < ApplicationController

before_action :authenticate_user!

  # GET /boms
  # GET /boms.json
  def index
    @boms = Bom.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boms }
    end
  end

  # GET /boms/1
  # GET /boms/1.json
  def show
    @bom = Bom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bom }
    end
  end

  # GET /boms/new
  # GET /boms/new.json
  def new
    @bom = Bom.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bom }
    end
  end

  # GET /boms/1/edit
  def edit
    @bom = Bom.find(params[:id])
  end

  # POST /boms
  # POST /boms.json
  def create
    @bom = Bom.new(params[:bom])

    respond_to do |format|
      if @bom.save
		format.html { redirect_to @bom, notice: 'Bom was successfully created.' }
        #format.html { redirect_to "products/2", notice: 'Bom was successfully created.' }
        format.json { render json: @bom, status: :created, location: @bom }
      else
        format.html { render action: "new" }
        format.json { render json: @bom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boms/1
  # PUT /boms/1.json
  def update
    @bom = Bom.find(params[:id])

    respond_to do |format|
      if @bom.update_attributes(params[:bom])
        format.html { redirect_to @bom, notice: 'Bom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boms/1
  # DELETE /boms/1.json
  def destroy
    @bom = Bom.find(params[:id])
    @bom.destroy

    respond_to do |format|
      format.html { redirect_to boms_url }
      format.json { head :no_content }
    end
  end
end
