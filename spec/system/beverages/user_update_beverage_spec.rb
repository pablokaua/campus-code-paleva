require 'rails_helper'

describe 'Usuário informa novo status a bebida' do 
  it 'a partir da tela de detalhes' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)

    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on beverage.name

    expect(page).to have_button "DESABILITAR"
    expect(page).not_to have_button "ATIVAR"
  end

  it 'e a bebida foi desabilitada' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)

    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on beverage.name
    click_on 'DESABILITAR'

    expect(current_path).to eq beverage_path(beverage.id)
    expect(page).to have_content 'ATIVAR'
    expect(page).not_to have_content 'DESABILITAR'
  end

  it 'e a bebida foi habilitada' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image, status: :inactive)

    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on beverage.name
    click_on 'ATIVAR'

    expect(current_path).to eq beverage_path(beverage.id)
    expect(page).to have_content 'DESABILITAR'
    expect(page).not_to have_content 'ATIVAR'
  end
end