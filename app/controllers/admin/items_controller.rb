class Admin::ItemsController < ApplicationController
  before_action :set_admin_item, only: %i[show edit update destroy]

  # GET /admin/items
  # GET /admin/items.json
  def index
    @items = Item.all
  end

  # GET /admin/items/1
  # GET /admin/items/1.json
  def show
  end

  # GET /admin/items/new
  def new
    @item = Item.new
  end

  # GET /admin/items/1/edit
  def edit
  end

  # POST /admin/items
  # POST /admin/items.json
  def create
    @item = Item.new item_params

    respond_to do |format|
      if @item.save
        format.html { redirect_to admin_items_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/items/1
  # PATCH/PUT /admin/items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to [:admin, @item], notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/items/1
  # DELETE /admin/items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to admin_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :quantity, :price, :remark, :user_id, :vendor, :features)
    end
end
