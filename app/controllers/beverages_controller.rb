class BeveragesController < ApplicationController
  before_action :set_beverage_check_user, only: [:show, :edit, :update, :destroy]
  def index 
    @restaurant = current_user.restaurant
    @beverages = @restaurant.beverages
  end

  def show 
  end

  def new 
    @beverage = Beverage.new
  end

  def create 
    beverage_params = params.require(:beverage).permit(:name, :description, :calories, :alcoholic)
    @beverage = Beverage.new(beverage_params)
    @beverage.restaurant = current_user.restaurant

    if @beverage.save 
      redirect_to @beverage, notice: 'Bebida cadastrada com sucesso'
    else
      flash.now[:alert] = "Não foi possível registrar a bebida."
      render :new
    end
  end

  def edit
  end

  def update
    beverage_params = params.require(:beverage).permit(:name, :description, :calories, :alcoholic)
    if @beverage.update(beverage_params)
      redirect_to @beverage, notice: 'Bebida editada com sucesso'
    else
      flash.now[:alert] = "Não foi possível editar a bebida"
      render :edit
    end
  end

  def destroy
    if @beverage.destroy 
      redirect_to beverages_path, notice: 'Bebida removida com sucesso'
    else
      flash.now[:alert] = "Não foi possível remover a bebida."
      render :index
    end
  end

  private 
  def set_beverage_check_user
    @beverage = Beverage.find(params[:id])
    if @beverage.restaurant.user != current_user
      redirect_to root_path, alert: 'Você não possui acesso a esta bebida'
    end
  end
end