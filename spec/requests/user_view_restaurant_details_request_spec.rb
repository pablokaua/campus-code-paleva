require 'rails_helper'

describe 'Usuário vê detalhes de um restaurante' do 
  it 'e não é o dono' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '50734184093', email: 'matheus@email.com', password: 'password1234')
    
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    Restaurant.create!(corporate_name: 'Outro Restaurante LTDA', brand_name: 'Outro Restaurante', registration_number: '98681667000100', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000002', email: 'contato@outro.com', user: other_user)

    login_as other_user
    get(restaurant_path(restaurant.id))

    expect(response).to redirect_to root_path
  end
end