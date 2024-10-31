class ItemsController < ApplicationController
  def search 
    @value = params[:query]

    @items = Item.where("name LIKE :search OR description LIKE :search", search: "%#{@value}%")
  end
end