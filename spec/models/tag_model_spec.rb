require 'rails_helper'

RSpec.describe TagModel, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'falso quando descrição é vazia' do 
        tag_model = TagModel.new(description: '')

        tag_model.valid?

        expect(tag_model.errors.include? :description).to eq true
      end
    end

    context 'uniqueness' do 
      it 'falso quando a descrição de tag já está sendo utilizada' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
        TagModel.create!(description: 'Tag 1', restaurant: restaurant)

        tag_model = TagModel.new(description: 'Tag 1', restaurant: restaurant)
        tag_model.valid?

        expect(tag_model.errors.include? :description).to eq true
      end

      it 'verdadeiro quando a descrição está sendo utilizada por outro restaurante' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '42272677061', email: 'matheus@email.com', password: 'password1234')
        restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
        other_restaurant = Restaurant.create!(corporate_name: 'Restaurante 2 LTDA', brand_name: 'Restaurante 2', registration_number: '28189948000156', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000001', email: 'contato@restaurante.com', user: other_user)
        TagModel.create!(description: 'Tag 1', restaurant: other_restaurant)

        tag_model = TagModel.new(description: 'Tag 1', restaurant: restaurant)
        tag_model.valid?

        expect(tag_model.errors.include? :description).to eq false
      end
    end
  end 
end
