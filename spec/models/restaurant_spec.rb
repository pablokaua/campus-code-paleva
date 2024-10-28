require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'falso quando a razão social é vazia' do 
        restaurant = Restaurant.new(corporate_name: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :corporate_name).to eq true
      end

      it 'falso quando o nome fantasia é vazio' do 
        restaurant = Restaurant.new(brand_name: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :brand_name).to eq true
      end

      it 'falso quando o CNPJ é vazio' do 
        restaurant = Restaurant.new(registration_number: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :registration_number).to eq true
      end

      it 'falso quando o endereço é vazio' do 
        restaurant = Restaurant.new(full_address: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :full_address).to eq true
      end

      it 'falso quando a cidade é vazia' do 
        restaurant = Restaurant.new(city: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :city).to eq true
      end

      it 'falso quando o estado é vazio' do 
        restaurant = Restaurant.new(state: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :state).to eq true
      end

      it 'falso quando o telefone é vazio' do 
        restaurant = Restaurant.new(phone_number: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :phone_number).to eq true
      end

      it 'falso quando o email é vazio' do 
        restaurant = Restaurant.new(email: '')
        
        restaurant.valid?

        expect(restaurant.errors.include? :email).to eq true
      end

      it 'falso quando o usuário é vazio' do 
        restaurant = Restaurant.new(user: nil)
        
        restaurant.valid?

        expect(restaurant.errors.include? :user).to eq true
      end
    end

    context 'email' do 
      it 'falso quando email é inválido'  do 
        restaurant = Restaurant.new(email: 'email')

        restaurant.valid?

        expect(restaurant.errors.include? :email).to eq true
        expect(restaurant.errors[:email]).to include 'inválido'
      end
    end

    context 'uniqueness' do
      it 'falso quando o CNPJ já está sendo utilizado' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

        restaurant = Restaurant.new(registration_number: '97311218000107')

        restaurant.valid?

        expect(restaurant.errors.include? :registration_number).to eq true
      end

      it 'falso quando a razão social já está sendo utilizada' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

        restaurant = Restaurant.new(corporate_name: 'Rede Hamburguer Rei LTDA')

        restaurant.valid?

        expect(restaurant.errors.include? :corporate_name).to eq true
      end

      it 'falso quando o e-mail já está sendo utilizado' do 
        user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
        Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

        restaurant = Restaurant.new(email: 'contato@hambuguer.com')

        restaurant.valid?

        expect(restaurant.errors.include? :email).to eq true
      end
    end

    context 'cnpj_validated' do 
      it 'falso quando o CNPJ é inválido' do 
        restaurant = Restaurant.new(registration_number: '7777777')

        restaurant.valid?

        expect(restaurant.errors.include? :registration_number).to eq true
        expect(restaurant.errors[:registration_number]).to include 'inválido'
      end
    end

    context 'length' do 
      it 'telefone não deve ser menor que 10 caracteres' do 
        restaurant = Restaurant.new(phone_number: '111111111')

        restaurant.valid?

        expect(restaurant.errors.include? :phone_number).to eq true
        expect(restaurant.errors[:phone_number]).to include 'deve ter no mínimo 10 caracteres'
      end

      it 'telefone não deve ser maior que 11 caracteres' do 
        restaurant = Restaurant.new(phone_number: '111111111111')

        restaurant.valid?

        expect(restaurant.errors.include? :phone_number).to eq true
        expect(restaurant.errors[:phone_number]).to include 'deve ter no máximo 11 caracteres'
      end

      it 'telefone deve ser igual a 10 ou 11 caracteres' do 
        restaurant = Restaurant.new(phone_number: '11111111111')

        restaurant.valid?

        expect(restaurant.errors.include? :phone_number).to eq false
      end
    end

    context '' 
  end

  describe 'gera código aleatório' do 
    it 'ao criar um novo restaurante' do 
      user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
      restaurant = Restaurant.new(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
      restaurant.save!
      result = restaurant.code 

      expect(result).not_to be_empty
      expect(result.length).to eq 6
    end

    it 'e o código é único' do 
      user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
      other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '38126942045', email: 'matheus@email.com', password: 'password1234')
      first_restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
      second_restaurant = Restaurant.new(corporate_name: 'Rede Mec Duck LTDA', brand_name: 'Mec Duck', registration_number: '82091692000195', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@mecduck.com', user: other_user)

      second_restaurant.save!

      expect(second_restaurant.code).not_to eq first_restaurant.code
    end
  end
end
