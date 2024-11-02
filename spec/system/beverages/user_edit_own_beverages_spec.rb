require 'rails_helper'

describe 'Usuário edita bebida ' do 
  it 'e deve estar autenticado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
    
    visit edit_dish_path(beverage.id) 
    
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
    
    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on beverage.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Suco de uva'
    fill_in 'Descrição', with: 'Bebida feita com uvas'
    fill_in 'Calorias', with: '150'
    choose("alcoholic_false")  
    click_on 'Gravar'

    expect(page).to have_content 'Bebida editada com sucesso'
    expect(page).to have_content 'Suco de uva'
    expect(page).to have_content "Alcoólica: Não"
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'Bebida feita com uvas'
    expect(page).to have_content 'Calorias: 150g'
    expect(page).to have_css 'img[src*="image.png"]'
  end

  it 'caso seja o responsável' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '28143953009', email: 'matheus@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    other_restaurant = Restaurant.create!(corporate_name: 'Rede Mec Ducks LTDA', brand_name: 'Mec Ducks', registration_number: '37530632000177', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11800000000', email: 'contato@mecducks.com', user: other_user)

    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
 
    login_as other_user 
    visit edit_beverage_path(beverage.id)

    expect(page).to have_content 'Você não possui acesso a esta bebida'
    expect(current_path).to eq root_path  
  end
end