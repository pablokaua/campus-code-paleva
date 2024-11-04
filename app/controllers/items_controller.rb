class ItemsController < ApplicationController
  def search 
    @value = params[:query]

    @items = Item.where("name LIKE :search OR description LIKE :search", search: "%#{@value}%")
  end

  def disable 
    @item = Item.find(params[:id])
    @item.inactive!
    redirect_back(fallback_location: root_path)
  end

  def enable 
    @item = Item.find(params[:id])
    @item.active!
    redirect_back(fallback_location: root_path)
  end
end