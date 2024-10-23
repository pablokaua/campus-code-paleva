require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'a partir da tela inicial' do 
    visit root_path
    click_on 'Criar uma Conta'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Sobrenome'
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_field 'Confirme sua senha'
    expect(page).to have_button 'Criar Conta'
    expect(current_path).to eq new_user_registration_path
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Criar uma Conta'
    fill_in 'Nome', with: 'Pablo'
    fill_in 'Sobrenome', with: 'Kauã'
    fill_in 'CPF', with: '80069982058'
    fill_in 'E-mail', with: 'pablo@gmail.com'
    fill_in 'Senha', with: 'password12345'
    fill_in 'Confirme sua senha', with: 'password12345'
    click_on 'Criar Conta'

    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    user = User.last
    expect(user.name).to eq 'Pablo'
  end

  it 'com dados incompletos' do 
    visit root_path
    click_on 'Criar uma Conta'
    fill_in 'Nome', with: ''
    fill_in 'Sobrenome', with: ''
    fill_in 'CPF', with: ''
    click_on 'Criar Conta'

    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Sobrenome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'CPF inválido'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end