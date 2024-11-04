class TagModelsController < ApplicationController
  def index 
    @tag_models = TagModel.all
  end

  def show 
    @tag_model = TagModel.find(params[:id])
  end
  def new 
    @tag_model = TagModel.new
  end

  def create 
    tag_model_params = params.require(:tag_model).permit(:description)
    @tag_model = TagModel.new(tag_model_params)
    @tag_model.restaurant = current_user.restaurant

    if @tag_model.save 
      redirect_to @tag_model, notice: 'Modelo de marcador cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o modelo de produto'
      render :new 
    end
  end
end