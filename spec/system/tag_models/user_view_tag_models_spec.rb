require 'rails_helper'

describe 'Usuário vê modelos de marcadores' do 
  it 'a partir do menu' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    login_as user 
    visit root_path 
    within 'nav' do 
      click_on 'Modelos de Marcadores'
    end

    expect(current_path).to eq tag_models_path
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    TagModel.create!(description: 'Tag 1', restaurant: restaurant)
    TagModel.create!(description: 'Tag 2', restaurant: restaurant)


    login_as user 
    visit root_path 
    click_on 'Modelos de Marcadores'

    expect(page).to have_content 'Modelos de Marcadores'
    expect(page).to have_content 'Tag 1'
    expect(page).to have_content 'Tag 2'
  end

  it 'e não existem modelos de marcadores cadastrados' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    login_as user 
    visit root_path 
    click_on 'Modelos de Marcadores'

    expect(page).to have_content 'Nenhum modelo de marcador cadastrado'
  end
end