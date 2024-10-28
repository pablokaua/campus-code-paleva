require 'rails_helper'

describe 'Usuário cadastra um novo prato' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
  
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Registrar Prato'

    expect(current_path).to eq new_dish_path 
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Registrar Prato'
    fill_in 'Nome', with: 'Prato Novo'
    fill_in 'Descrição', with: 'Descrição do Prato Novo'
    fill_in 'Calorias', with: '150'
    click_on 'Gravar'

    expect(page).to have_content 'Prato cadastrado com sucesso'
    expect(page).to have_content 'Prato Novo'
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'Descrição do Prato Novo'
    expect(page).to have_content 'Calorias: 150g'
  end

  it 'com campos incompletos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Registrar Prato'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Calorias', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível registrar o prato.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
end