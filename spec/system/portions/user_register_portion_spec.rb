require 'rails_helper' 

describe 'Usuário cadastra porção para item' do 
  it 'a partir da tela inical' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on 'Prato 1'
    click_on 'Adicionar Porção'

    expect(page).to have_content 'Cadastrar Porção'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Preço'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on 'Prato 1'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: 'Porção Pequena'
    fill_in 'Preço', with: '10.20'
    click_on 'Enviar'

    expect(page).to have_content 'Porção Pequena'
    expect(page).to have_content 'R$ 10.2'
  end

  it 'com campos incompletos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Prato 1', description: 'descrição 1', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on 'Prato 1'
    click_on 'Adicionar Porção'
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível registrar a porção'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Preço não pode ficar em branco'
  end 
end