require 'rails_helper'

describe 'Usuário vê porções de um item' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

    Portion.create!(description: 'Porção Pequena', current_price: 10.20, item: dish)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on 'Prato 1'

    expect(page).to have_content 'Prato 1'
    expect(page).to have_content 'Porção Pequena'
    expect(page).to have_content 'R$ 10.2'
  end

  it 'e não vê porções de outro item' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    beverage = Beverage.create!(name: 'Bebida 1', description: 'Bebida feita com blabla', calories: 115, alcoholic: true,restaurant: restaurant, photo: attach_image)
    dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

    Portion.create!(description: 'Porção Pequena', current_price: 10.20, item: dish)
    Portion.create!(description: 'Porção Grande', current_price: 20.20, item: beverage)

    login_as user 
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on 'Bebida 1'

    expect(page).to have_content 'Porção Grande'
    expect(page).not_to have_content 'Porção Pequena'
  end
end