require 'rails_helper' 

describe 'Usuário remove bebida' do 
  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
    
    login_as user 
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on beverage.name 
    click_on 'Excluir' 
    
    expect(current_path).to eq beverages_path 
    expect(page).to have_content 'Bebida removida com sucesso'
    expect(page).not_to have_content 'Cachaça'
    expect(page).not_to have_content 'Restaurante: Hamburguer Rei'
    expect(page).not_to have_content 'Calorias: 115g'
    expect(page).not_to have_css 'img[src*="image.png"]'
  end

  it 'e não remove outras bebidas' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    first_beverage = Beverage.create!(name: 'Cachaça', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
    second_beverage = Beverage.create!(name: 'Suco de maçã', description: 'Bebida feita com blabla', calories: 115, alcoholic: false,restaurant: restaurant, photo: attach_image)
    
    login_as user 
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on first_beverage.name 
    click_on 'Excluir' 
    
    expect(current_path).to eq beverages_path 
    expect(page).to have_content 'Bebida removida com sucesso'
    expect(page).not_to have_content 'Cachaça'
    expect(page).to have_content 'Suco de maçã'
  end
end