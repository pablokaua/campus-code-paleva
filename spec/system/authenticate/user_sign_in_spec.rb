require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'a partir da página inicial' do 
    visit root_path

    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Senha'
    expect(page).to have_button 'Entrar'
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do 
    User.create!(cpf: '98624520053',name: 'Pablo',last_name: 'Kaua', email: 'pablo@email.com', password: 'password12345')

    visit root_path
    within 'form' do 
      fill_in 'E-mail', with: 'pablo@email.com'
      fill_in 'Senha', with: 'password12345'
      click_on 'Entrar'
    end
    
    within 'nav' do 
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Entrar'  
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'com dados incompletos' do 
    visit root_path
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválidos'
  end

  it 'faz logout' do 
    user = User.create!(cpf: '98624520053',name: 'Pablo',last_name: 'Kaua', email: 'pablo@email.com', password: 'password12345')

    login_as(user)
    visit root_path
    
    click_on 'Sair'

    expect(page).not_to have_button 'Sair'
  end
end