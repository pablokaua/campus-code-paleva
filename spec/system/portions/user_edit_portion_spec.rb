require 'rails_helper' 

describe 'Usuário edita uma porção' do 
  it 'e deve está autenticado' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    portion = Portion.create!(description: 'Porção pequena', current_price: 10, item: dish)

    visit edit_item_portion_path(dish.id, portion.id)
    
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    Portion.create!(description: 'Porção pequena', current_price: 10, item: dish)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Editar Porção'
    fill_in 'Preço', with: "10.2"
    click_on 'Enviar' 
    
    expect(page).to have_content 'Porção atualizada com sucesso'
    expect(page).to have_content 'Porção pequena'
    expect(page).to have_content 'R$ 10.2'
  end

  it 'caso seja responsável' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    other_user = User.create!(name: 'Matheus', last_name: 'Trindade', cpf: '76186551032', email: 'matheus@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    portion = Portion.create!(description: 'Porção pequena', current_price: 10, item: dish)

    login_as other_user
    visit edit_item_portion_path(dish.id, portion.id)

    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui acesso a esta ação'
  end
end