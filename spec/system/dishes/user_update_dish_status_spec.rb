require 'rails_helper'

describe 'Usuário informa novo status ao prato' do 
  it 'a partir da tela de detalhes' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: 'descrição sobre o prato de comida', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name

    expect(page).to have_button "Desabilitar"
    expect(page).not_to have_button "Ativar"
  end

  it 'e prato foi desabilitado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: 'descrição sobre o prato de comida', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name
    click_on 'Desabilitar'

    expect(current_path).to eq dish_path(dish.id)
    expect(page).to have_content 'Ativar'
    expect(page).not_to have_content 'Desabilitar'
  end

  it 'e o prato foi habilitado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: 'descrição sobre o prato de comida', calories: 100, restaurant: restaurant, photo: attach_image, status: :inactive)

    login_as user
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name
    click_on 'Ativar'

    expect(current_path).to eq dish_path(dish.id)
    expect(page).to have_content 'Desabilitar'
    expect(page).not_to have_content 'Ativar'
  end
end