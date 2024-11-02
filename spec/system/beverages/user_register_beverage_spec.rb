require 'rails_helper' 

describe 'Usuário cadastra nova bebida' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
  
    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Registrar Bebida'

    expect(current_path).to eq new_beverage_path 
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
    expect(page).to have_content 'Alcoólica'
    expect(page).to have_content 'Foto'
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
  
    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Registrar Bebida'
    fill_in 'Nome', with: 'Cachaça'
    fill_in 'Descrição', with: 'Bebida feita com blabla'
    fill_in 'Calorias', with: '150'
    choose("alcoholic_true")  
    attach_file('Foto', Rails.root.join('spec/fixtures/image.png'))
    click_on 'Gravar'

    expect(page).to have_content 'Detalhes da Bebida'
    expect(page).to have_content 'Cachaça'
    expect(page).to have_content "Alcoólica: Sim"
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content 'Bebida feita com blabla'
    expect(page).to have_content 'Calorias: 150g'
    expect(page).to have_css 'img[src*="image.png"]'
  end

  it 'com campos incompletos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
  
    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Registrar Bebida'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível registrar a bebida.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Deve informar se a bebida é alcoólica ou não'
    expect(page).to have_content 'Foto não deve ser vazia'
  end
end