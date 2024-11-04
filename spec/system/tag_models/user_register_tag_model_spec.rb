require 'rails_helper' 

describe 'Usuário cadastra modelo de marcador' do 
  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
   
    login_as user 
    visit root_path 
    click_on 'Modelos de Marcadores'
    click_on 'Cadastrar Novo'
    fill_in 'Descrição', with: 'Tag 99'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo de marcador cadastrado com sucesso'
    expect(page).to have_content 'Tag 99'
  end 

  it 'e deve preencher todos os campos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
   
    login_as user 
    visit root_path 
    click_on 'Modelos de Marcadores'
    click_on 'Cadastrar Novo'
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
end