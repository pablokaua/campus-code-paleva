require	 'rails_helper'

describe 'Usuário busca por uma bebida' do 
  it 'a partir do menu' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    login_as user 
    visit root_path 

    within 'header nav' do 
      expect(page).to have_field 'Buscar por item'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra um prato por nome' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    first_beverage = Beverage.create!(name: 'Cachaça', description: 'bebida blabla', calories: 150, alcoholic: true, restaurant: restaurant)
    second_beverage = Beverage.create!(name: 'Suco de Maracujá', description: 'bebida blabla', calories: 100,alcoholic: false, restaurant: restaurant)

    login_as user 
    visit root_path 
    fill_in 'Buscar por item', with: first_beverage.name
    click_on 'Buscar'

    expect(page).to have_content 'Cachaça'
    expect(page).not_to have_content 'Suco de Maracujá'
  end

  it 'e encontra uma bebida por descrição' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    first_beverage = Beverage.create!(name: 'Cachaça', description: 'decrição 1', calories: 150, alcoholic: true, restaurant: restaurant)
    second_beverage = Beverage.create!(name: 'Suco de Maracujá', description: 'decrição 2', calories: 100,alcoholic: false, restaurant: restaurant)

    login_as user 
    visit root_path 
    fill_in 'Buscar por item', with: first_beverage.description
    click_on 'Buscar'

    expect(page).to have_content 'Cachaça'
    expect(page).not_to have_content 'Suco de Maracujá'
  end

  it 'e não encontra nenhuma bebida' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)


    login_as user 
    visit root_path 
    fill_in 'Buscar por item', with: 'Bebida'
    click_on 'Buscar'

    expect(page).to have_content 'Nenhum item encontrado'
  end

  it 'e acessa detalhes da bebida' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    beverage = Beverage.create!(name: 'Cachaça', description: 'decrição 1', calories: 150, alcoholic: true, restaurant: restaurant)

    login_as user 
    visit root_path 
    fill_in 'Buscar por item', with: beverage.name
    click_on 'Buscar'
    click_on beverage.name

    expect(current_path).to eq beverage_path(beverage.id)
    expect(page).to have_content 'Detalhes da Bebida'
    expect(page).to have_content beverage.name
    expect(page).to have_content "Alcoólica: Sim"
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'decrição 1'
    expect(page).to have_content 'Calorias: 150g'
  end 

  it 'e edita uma bebida' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    beverage = Beverage.create!(name: 'Cachaça', description: 'decrição 1', calories: 150, alcoholic: true, restaurant: restaurant)

    login_as user 
    visit root_path 
    fill_in 'Buscar por item', with: beverage.name
    click_on 'Buscar'
    click_on 'Editar'

    expect(current_path).to eq edit_beverage_path(beverage.id)
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
    expect(page).to have_content 'Alcoólica'
  end
end