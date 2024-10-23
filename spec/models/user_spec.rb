require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
    context 'uniqueness' do 
      it 'falso quando cpf já está sendo utilizado' do 
        User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '55284455070', email: 'matheus@email.com', password: 'password12345')
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '55284455070', email: 'pablo@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end

      it 'falso quando email já está sendo utilizado' do 
        User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '55284455070', email: 'email@email.com', password: 'password12345')
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '55284455071', email: 'email@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end
    end

    context 'presence' do 
      it 'falso quando nome é vazio' do 
        user = User.new(name: '', last_name: 'Kaua', cpf: '55284455070', email: 'pablo@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end 

      it 'falso quando sobrenome é vazio' do 
        user = User.new(name: 'Pablo', last_name: '', cpf: '55284455070', email: 'pablo@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end 

      it 'falso quando CPF é vazio' do 
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '', email: 'pablo@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end
      
      it 'falso quando email é vazio' do 
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '55284455070', email: '', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end 

      it 'falso quando senha é vazio' do 
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '55284455070', email: 'pablo@email.com', password: '')

        result = user.valid?

        expect(result).to eq false
      end 
    end

    context 'length_minimum' do 
      it 'falso quando senha é menor do que 12 caracteres' do 
        user = User.new(name: 'Matheus', last_name: 'Trindade', cpf: '55284455070', email: 'email@email.com', password: 'password123')

        result = user.valid?

        expect(result).to eq false
      end
    end

    context 'cpf_validated' do
      it 'falso quando CPF é inválido' do 
        user = User.new(name: 'Pablo', last_name: 'Kaua', cpf: '5528445507', email: 'pablo@email.com', password: 'password12345')

        result = user.valid?

        expect(result).to eq false
      end
    end
  end
end
