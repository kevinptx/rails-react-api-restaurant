class Api::ItemsController < ApplicationController
  before_action :set_menu, only: [:index, :create]
  before_action :set_item, only: [ :destroy]

  #GET
  def index
    render json: @menu.items.all
  end

  #POST
  def create
    item = @menu.items.new(item_params)
    if item.save
      render json: item
    else
      render json: {errors: item.errors}, status: :unprocessable_entity
    end
  end

  #PUT/PATCH
  def update
    @item.update(item_params)
    render json: @item
  end

  #DELETE
  def destroy
    @item.destroy
    render json: {message: "Item deleted"}
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end
end
