require 'rails_helper'

describe 'Usuário vê seus prórpios pratos' do 
  it 'e deve estar autenticado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)

    visit dish_path(dish.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pratos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    first_dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    second_dish = Dish.create!(name: 'Burrito', description: '135g de blablabla', calories: 323, restaurant: other_restaurant, photo: attach_image, status: :inactive)
    third_dish = Dish.create!(name: 'Empada de frango', description: '89g de blablbla', calories: 298, restaurant: restaurant, photo: attach_image)
    
    login_as user
    visit root_path 
    click_on 'Meus Pratos'

    expect(page).to have_content first_dish.name
    expect(page).to have_content first_dish.restaurant.brand_name
    expect(page).to have_content first_dish.calories
    expect(page).to have_content "Status do Item: Ativo"
    expect(page).not_to have_content second_dish.name
    expect(page).not_to have_content second_dish.restaurant.brand_name
    expect(page).not_to have_content second_dish.calories
    expect(page).not_to have_content "Status do Item: Desativado"
    expect(page).to have_content third_dish.name
    expect(page).to have_content third_dish.restaurant.brand_name
    expect(page).to have_content third_dish.calories
     expect(page).to have_content "Status do Item: Ativo"
  end


  it 'e visita um prato' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: 'descrição sobre o prato de comida', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name

    expect(page).to have_content 'Detalhes do Prato'
    expect(page).to have_content dish.name
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'descrição sobre o prato de comida'
    expect(page).to have_content 'Calorias: 100g'
    expect(page).to have_content "Status do Item: Ativo"
    expect(page).to have_css('img[src*="image.png"]')
  end

  it 'e não visita pratos de outros usuários' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    dish = Dish.create!(name: 'Burrito', description: '135g de blablabla', calories: 323, restaurant: restaurant, photo: attach_image)

    login_as other_user
    visit dish_path(dish.id)

    expect(current_path).not_to eq dish_path(dish.id)
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui acesso a este prato'
  end
end