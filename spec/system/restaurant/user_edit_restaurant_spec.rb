require 'rails_helper'

describe 'Usuário edita restaurante' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user
    visit root_path 
    click_on 'Meu Restaurante'
    click_on 'Editar'

    expect(current_path).to eq edit_restaurant_path(restaurant.id)
    expect(page).to have_content 'Editar Restaurante'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user
    visit root_path 
    click_on 'Meu Restaurante'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Burger King'
    fill_in 'Razão Social', with: 'Burger King LTDA'
    click_on 'Gravar'

    expect(page).to have_content 'Restaurante editado com sucesso' 
    expect(page).to have_content 'Burger King'  
    expect(page).to have_content 'Razão Social: Burger King LTDA'  
  end

  it 'caso seja o responsável' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '50734184093', email: 'matheus@email.com', password: 'password1234')
    
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    Restaurant.create!(corporate_name: 'Outro Restaurante LTDA', brand_name: 'Outro Restaurante', registration_number: '98681667000100', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000002', email: 'contato@outro.com', user: other_user)

    login_as other_user
    visit edit_restaurant_path(restaurant.id)

    expect(page).to have_content 'Você não possui acesso a essas informações'
    expect(current_path).to eq root_path
  end 
end