class ProductsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  #load_and_authorize_resource except: [:create]

  def bomlist
    @bom = Bom.find("product_id = ?", params[:id])
  end

  # GET /products
  # GET /products.json
  def index
    @products_grid = initialize_grid(Product.all, :order => 'products.name')
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @boms = Bom.includes(:product, :subproduct).where(product_id: [params[:id]])
    @activity_items_grid = initialize_grid(@product.activity_items, include: [activity: [:activity_type, :from_organization, :to_organization]]) 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @activity_items_grid = initialize_grid(@product.activity_items, include: [:activity]) 
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        #format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def product_params
    params.require(:product).permit(:id, :name, :articul,
      :sale_price, :active, :forsale, :note, :measure)
  end


  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def ajax_get
    respond_to do |format|
      format.json { render :json => Product.where('name like :term', { :term => params[:term] + '%' }).limit(10).select('id,name') }
    end
  end
end
