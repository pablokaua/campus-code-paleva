require	 'rails_helper'

describe 'Usuário busca por um prato' do 
  it 'a partir do menu' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'

    expect(page).to have_field 'Buscar por item'
    expect(page).to have_button 'Buscar' 
  end

  it 'e encontra um prato por nome' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    first_dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    second_dish = Dish.create!(name: 'Burrito', description: '135g de blablabla', calories: 323, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    fill_in 'Buscar por item', with: first_dish.name
    click_on 'Buscar'

    expect(page).to have_content 'Canja de frango'
    expect(page).not_to have_content 'Burrito'
    expect(page).to have_content 'Status do Item: Ativo'
  end

  it 'e encontra um prato por descrição' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    first_dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)
    second_dish = Dish.create!(name: 'Burrito', description: '135g de blablabla', calories: 323, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    fill_in 'Buscar por item', with: first_dish.description
    click_on 'Buscar'

    expect(page).to have_content 'Canja de frango'
    expect(page).not_to have_content 'Burrito'
    expect(page).to have_content 'Status do Item: Ativo'
  end

  it 'e não encontra nenhum prato' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)


    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    fill_in 'Buscar por item', with: 'Prato'
    click_on 'Buscar'

    expect(page).to have_content 'Nenhum item encontrado'
  end

  it 'e acessa detalhes do prato' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    fill_in 'Buscar por item', with: dish.name
    click_on 'Buscar'
    click_on dish.name

    expect(current_path).to eq dish_path(dish.id)
    expect(page).to have_content 'Detalhes do Prato'
    expect(page).to have_content dish.name
    expect(page).to have_content 'Restaurante: Hamburguer Rei'
    expect(page).to have_content '100g de Canja de frango blabla'
    expect(page).to have_content 'Calorias: 100g'
    expect(page).to have_content 'Status do Item: Ativo'
    expect(page).to have_css 'img[src*="image.png"]'
  end 

  it 'e edita um prato' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')

    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)

    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant, photo: attach_image)

    login_as user 
    visit root_path 
    click_on 'Meus Pratos'
    fill_in 'Buscar por item', with: dish.name
    click_on 'Buscar'
    click_on 'Editar'

    expect(current_path).to eq edit_dish_path(dish.id)
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
    expect(page).to have_field 'Foto'
  end
end