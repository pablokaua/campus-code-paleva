require 'rails_helper'

RSpec.describe Portion, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'falso quando descrição é vazia' do 
        portion = Portion.new(description: '')

        portion.valid? 

        expect(portion.errors.include? :description).to eq true
      end

      it 'falso quando preço é vazio' do 
        portion = Portion.new(current_price: '')

        portion.valid? 

        expect(portion.errors.include? :current_price).to eq true
      end
    end

    context 'uniqueness' do 
      it 'falso quando a descrição de porção já está sendo utilizada' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
        dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

        Portion.create!(description: 'descrição', current_price: 10.2, item: dish)
        
        portion = Portion.new(description: 'descrição', current_price: 10.2, item: dish)
        portion.valid?

        expect(portion.errors.include? :description).to eq true
      end

      it 'verdadeiro quando a descrição já está sendo usada por outro item' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
        dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)
        other_dish = Dish.create!(name: 'Prato 2', description: 'descrição 2', calories: 100, restaurant: restaurant, photo: attach_image)

        Portion.create!(description: 'descrição', current_price: 10.2, item: dish)
        
        portion = Portion.new(description: 'descrição', current_price: 10.2, item: other_dish)
        portion.valid?

        expect(portion.errors.include? :description).to eq false
      end
    end
  end
end
