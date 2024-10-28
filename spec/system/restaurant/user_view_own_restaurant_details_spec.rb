require 'rails_helper'

describe 'Usuário vê detalhes do restaurante' do 
  it 'a partir da tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user
    visit root_path 
    click_on 'Meu Restaurante'

    expect(page).to have_content 'Hamburguer Rei'  
    expect(page).to have_content 'Razão Social: Rede Hamburguer Rei LTDA'  
    expect(page).to have_content 'Endereço: Avenida Contorno Sul, 202 - São Paulo - SP'  
    expect(page).to have_content 'CNPJ: 97311218000107'  
    expect(page).to have_content 'E-mail: contato@hambuguer.com'  
    expect(page).to have_content 'Telefone: 11900000000'  
  end

  it 'e volta para tela inicial' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    
    login_as user
    visit root_path 
    click_on 'Meu Restaurante'
    click_on 'PaLevá'

    expect(current_path).to eq root_path
  end
end