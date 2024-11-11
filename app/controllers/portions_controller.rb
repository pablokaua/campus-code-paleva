class PortionsController < ApplicationController 
  before_action :set_item, only: [:new, :create, :edit, :update]
  before_action :set_portion_and_check_user, only: [:edit, :update]
  def new 
    @portion = @item.portions.build
  end

  def create     
    @portion = @item.portions.new(portion_params)
    
    if @portion.save
      redirect_to @item, notice: 'Porção criada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar a porção'
      render :new
    end
  end

  def edit 
  end

  def update 
    if @portion.update(portion_params)
      redirect_to @item, notice: 'Porção atualizada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar a porção'
      render :edit 
    end
  end

  private 
  def set_item 
    @item = Item.find(params[:item_id])
  end

  def set_portion_and_check_user 
    @portion = @item.portions.find(params[:id])
    if @portion.item.restaurant.user != current_user 
      redirect_to root_path, alert: 'Você não possui acesso a esta ação'
    end
  end

  def portion_params
    params.require(:portion).permit(:description, :current_price)
  end
end