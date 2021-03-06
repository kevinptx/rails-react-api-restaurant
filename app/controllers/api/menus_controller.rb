class Api::MenusController < ApplicationController
  before_action :set_menu, only: [:destroy]

  #GET
  def index
    render json: Menu.all
  end

  #POST
  def create
    menu = Menu.new(menu_params)
    if menu.save
      render json: menu
    else
      render json: {errors: menu.errors}, status: :unprocessable_entity
    end
  end

  #PUT/PATCH
  def update
    @menu.update
    render json: @menu
  end

  #DELETE
  def destroy
    @menu.destroy
    render json: {message: "Menu Deleted"}
  end

  private

  def menu_params
    params.require(:menu).permit(:name)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
