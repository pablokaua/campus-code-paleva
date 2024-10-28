require 'rails_helper'

describe 'Usuário vê suas bebidas' do 
  it 'e não vê outras bebidas' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    first_beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant)
    second_beverage = Beverage.create!(name: 'Espumante', description: 'Bebida feita com blabla', calories: 110, alcoholic: true, restaurant: other_restaurant)
    third_beverage = Beverage.create!(name: 'Gim', description: 'Bebida feita com blabla', calories: 60, alcoholic: true, restaurant: restaurant)
    
    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'

    expect(page).to have_content first_beverage.name
    expect(page).to have_content first_beverage.restaurant.brand_name
    expect(page).to have_content first_beverage.calories
    expect(page).not_to have_content second_beverage.name
    expect(page).not_to have_content second_beverage.restaurant.brand_name
    expect(page).not_to have_content second_beverage.calories
    expect(page).to have_content third_beverage.name
    expect(page).to have_content third_beverage.restaurant.brand_name
    expect(page).to have_content third_beverage.calories
  end

  it 'e visita uma bebida' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant)
    
    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on beverage.name

    expect(page).to have_content 'Detalhes da Bebida'
    expect(page).to have_content beverage.name
    expect(page).to have_content "Alcoólica: Sim"
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'Bebida feita com blabla'
    expect(page).to have_content 'Calorias: 115g'
  end

  it 'e não visita pratos de outros usuários' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant)
    
    login_as other_user
    visit beverage_path(beverage.id)

    expect(current_path).not_to eq beverage_path(beverage.id)
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui acesso a esta bebida'
  end
end