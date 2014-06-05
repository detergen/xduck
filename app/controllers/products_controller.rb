class ProductsController < ApplicationController
<<<<<<< HEAD
load_and_authorize_resource
=======
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450
	def bomlist
		@bom = Bom.find("product_id = ?", params[:id]) 
	end
  # GET /products
  # GET /products.json
  def index
<<<<<<< HEAD
#    @products = Product.all
=======
    @products = Product.all
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
<<<<<<< HEAD
#    @product = Product.find(params[:id])
=======
    @product = Product.find(params[:id])
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450
	#@boms = Bom.find(:all, :conditions => "product_id = ?", params[:id]) 
	@boms = Bom.includes(:product, :subproduct).where(product_id: [params[:id]]) 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
<<<<<<< HEAD
#    @product = Product.new
=======
    @product = Product.new
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
<<<<<<< HEAD
#    @product = Product.find(params[:id])
=======
    @product = Product.find(params[:id])
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450
  end

  # POST /products
  # POST /products.json
  def create
<<<<<<< HEAD
 #   @product = Product.new(params[:product])
=======
    @product = Product.new(params[:product])
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

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

  # PUT /products/1
  # PUT /products/1.json
  def update
<<<<<<< HEAD
 #   @product = Product.find(params[:id])
=======
    @product = Product.find(params[:id])
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450

    respond_to do |format|
      if @product.update_attributes(params[:product])
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
<<<<<<< HEAD
 #   @product = Product.find(params[:id])
=======
    @product = Product.find(params[:id])
>>>>>>> 1200571a19aad4a8b8271d24fdce6e7a0dc09450
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
