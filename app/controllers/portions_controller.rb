class PortionsController < ApplicationController 
  before_action :set_item, only: [:new, :create]
  def new 
    @portion = Portion.new
  end

  def create 
    portion_params = params.require(:portion).permit(:description, :current_price)
    
    @portion = @item.portions.new(portion_params)
    
    if @portion.save
      redirect_to @item, notice: 'Porção criada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar a porção'
      render :new
    end
  end

  def set_item 
    @item = Item.find(params[:item_id])
  end
end