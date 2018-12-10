class Api::ItemsController < ApplicationController
  before_action :set_item, only: [:update, :destroy]

  #GET
  def index
    render json: Item.order(:name)
  end

  #POST
  def create
    item = Item.new(item_params)
    if item.save
      render json: item
    else
      render json: {errors: item.errors}
    end
  end

  #PUT/PATCH
  def update
    @item.update
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
end
