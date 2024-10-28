class RestaurantsController < ApplicationController  
  before_action:set_restaurant_and_check_user, only: [:show, :edit, :update]
  def new 
    @restaurant = Restaurant.new
  end
  
  def create
    restaurant_params = params.require(:restaurant).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :phone_number, :email)
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user

    if @restaurant.save 
      redirect_to @restaurant, notice: 'Restaurante cadastrado com sucesso.'
    else
      flash.now[:alert] = "Não foi possível cadastrar o restaurante"
      render :new
    end
  end
  
  def show
  end

  def edit 
  end

  def update
    restaurant_params = params.require(:restaurant).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :phone_number, :email)
    if @restaurant.update(restaurant_params) 
      redirect_to @restaurant, notice: 'Restaurante editado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível editar o restaurante'
      render :edit
    end
  end

  private
  def set_restaurant_and_check_user
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user != current_user
      redirect_to root_path, alert: "Você não possui acesso a essas informações"
    end
  end
end