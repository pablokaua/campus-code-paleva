require 'rails_helper'

describe 'Usuário exclui prato' do 
  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant)
    
    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Excluir' 
    
    expect(current_path).to eq dishes_path 
    expect(page).to have_content 'Prato removido com sucesso'
    expect(page).not_to have_content 'Canja de frango'
    expect(page).not_to have_content 'Restaurante: Hamburguer Rei'
    expect(page).not_to have_content 'Calorias: 100g'
  end

  it 'não apaga outros pratos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    first_dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant)
    second_dish = Dish.create!(name: 'Prato 2', description: 'Decrição prato 2', calories: 200, restaurant: restaurant)
    
    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on first_dish.name 
    click_on 'Excluir' 
    
    expect(current_path).to eq dishes_path 
    expect(page).to have_content 'Prato removido com sucesso'
    expect(page).to have_content 'Prato 2'
    expect(page).not_to have_content 'Canja de frango'
  end 
end