class Admin::ItemsController < ApplicationController
  # @item
  before_action :set_item, only: %i[show edit update destroy]
  # 須先登入
  before_action :authenticate_user!
  # dataTable
  include Datatable

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
    @item = current_user.items.new item_params

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

  def download
    Axlsx::Package.new do |package|
      package.workbook.add_worksheet(name: example[:file_name]) do |sheet|
        # excel 標題
        sheet.add_row example[:title], types: %i[string string string string]
        # excel 內文
        example[:content].each do |content|
          sheet.add_row content, types: %i[string string string string]
        end
      end

      send_data(package.to_stream.read, filename: "#{example[:file_name]}.xlsx")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item)
          .permit(:name, :quantity, :price, :remark,
                  :user_id, :vendor, :features, pictures: [])
  end

  def search_params
    return if params[:ransack_search].nil?

    params.require(:ransack_search)
          .permit(:order_status_eq, :created_at_gteq, :created_at_lt)
          .merge(number_or_order_customer_phone_or_order_customer_name_cont: params[:search][:value])
  end

  def viewable_lists(filtered_sub_orders)
    default_viewable_lists filtered_sub_orders, %i[name quantity price remark user_email vendor id id id]
  end

  # 匯出範例
  def example
    {
      file_name: '紀錄匯出',
      title: %w(名稱 數量 價錢 備註 使用者email 供應商),
      content: Item.includes(:user)
                   .map { |i| [i.name, i.quantity, i.price, i.remark, i.user.email, i.vendor] }
    }
  end
end
