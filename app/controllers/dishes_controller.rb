class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dish_check_user, only: [:show, :edit, :update, :destroy]
  def index
    @restaurant = current_user.restaurant
    @dishes = @restaurant.dishes
  end

  def new 
    @dish = Dish.new
  end

  def create 
    dish_params = params.require(:dish).permit(:name, :description, :calories, :photo)
    @dish = Dish.new(dish_params)
    @dish.restaurant = current_user.restaurant

    if @dish.save 
      redirect_to @dish, notice: 'Prato cadastrado com sucesso'
    else
      flash.now[:alert] = "Não foi possível registrar o prato."
      render :new
    end
  end
  def show
  end


  def edit 
  end

  def update
    dish_params = params.require(:dish).permit(:name, :description, :calories)
    if @dish.update(dish_params)
      redirect_to @dish, notice: 'Prato editado com sucesso'
    else
      flash.now[:alert] = "Não foi possível editar o prato."
      render :edit
    end
  end

  def destroy
    if @dish.destroy 
      redirect_to dishes_path, notice: 'Prato removido com sucesso'
    else
      flash.now[:alert] = "Não foi possível remover o prato."
      render :index
    end
  end

  private
  def set_dish_check_user 
    @dish = Dish.find(params[:id])
    if @dish.restaurant.user != current_user
      redirect_to root_path, alert: 'Você não possui acesso a este prato'
    end
  end
end