require 'rails_helper'

describe 'Usuário cadastra seu restaurante' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    visit root_path
    fill_in 'E-mail', with: 'pablo@email.com' 
    fill_in 'Senha', with: 'password1234'
    click_on 'Entrar' 
    
    expect(current_path).to eq new_restaurant_path
    expect(page).to have_content 'Novo Restaurante'
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

    allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('ABC123')
    login_as user
    visit new_restaurant_path


    fill_in 'Nome Fantasia', with: 'Girafas'
    fill_in 'Razão Social', with: 'Rede de Alimentos Girafas LTDA'
    fill_in 'CNPJ', with: '94426927000131'
    fill_in 'Endereço', with: 'Avenida Dos Franceses, 108'
    fill_in 'Cidade', with: 'São Luís'
    fill_in 'Estado', with: 'MA'
    fill_in 'E-mail', with: 'contato@girafas.com'
    fill_in 'Telefone', with: '11900000000'
    click_on 'Gravar'

    expect(page).to have_content 'Restaurante cadastrado com sucesso.'  
    expect(page).to have_content 'Código: ABC123'  
    expect(page).to have_content 'Girafas'  
    expect(page).to have_content 'Razão Social: Rede de Alimentos Girafas LTDA'  
    expect(page).to have_content 'Endereço: Avenida Dos Franceses, 108 - São Luís - MA'  
    expect(page).to have_content 'CNPJ: 94426927000131'  
    expect(page).to have_content 'E-mail: contato@girafas.com'  
    expect(page).to have_content 'Telefone: 11900000000' 
  end

  it 'com dados incompletos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    login_as user
    visit new_restaurant_path

    fill_in 'Nome Fantasia', with: 'Girafas'
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível cadastrar o restaurante'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end