require 'rails_helper'

describe 'Usuário edita prato' do 
  it 'e deve estar autenticado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    
    visit edit_dish_path(dish.id) 
    
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant,photo: attach_image)
    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Editar'
    fill_in 'Nome', with: 'Novo nome'
    fill_in 'Descrição', with: 'Nova descrição'
    click_on 'Gravar'

    expect(page).to have_content 'Prato editado com sucesso'
    expect(page).to have_content 'Novo nome'
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'Nova descrição'
    expect(page).to have_content 'Calorias: 100g'
    expect(page).to have_css('img[src*="image.png"]')
  end

  it 'caso seja o responsável' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as other_user 
    visit edit_dish_path(dish.id)

    expect(page).to have_content 'Você não possui acesso a este prato'
    expect(current_path).to eq root_path  
  end
end