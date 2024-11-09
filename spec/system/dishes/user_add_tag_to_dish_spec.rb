require 'rails_helper' 

describe 'Usuário adiciona marcador ao prato' do 
  it 'com sucesso' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant,photo: attach_image)
    
    TagModel.create!(description: "Tag 1", restaurant: restaurant)
    TagModel.create!(description: "Tag 2", restaurant: restaurant)
    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Editar'
    check 'Tag 1'
    click_on 'Gravar' 
    
    expect(current_path).to eq dish_path(dish.id)
    expect(page).to have_content 'Tag 1'
  end

  it 'não altera marcadores de outros pratos' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Prato 1', description: 'Descrição 1', calories: 100, restaurant: restaurant,photo: attach_image)
    other_dish = Dish.create!(name: 'Prato 2', description: 'Descrição 2', calories: 200, restaurant: restaurant,photo: attach_image)
    
    tag_model = TagModel.create!(description: "Tag 1", restaurant: restaurant)
    other_tag_model = TagModel.create!(description: "Tag 2", restaurant: restaurant)

    ItemTag.create!(item: other_dish, tag_model: other_tag_model)

    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Editar'
    check 'Tag 1'
    click_on 'Gravar' 
    visit dish_path(other_dish.id)
    
    expect(page).to have_content 'Tag 2'
    expect(page).not_to have_content 'Tag 1'
  end

  it 'e precisa cadastrar marcador' do 
    user = User.create!(name: 'Pablo', last_name: 'Kaua', cpf: '40898591074', email: 'pablo@email.com', password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Rede Hamburguer Rei LTDA', brand_name: 'Hamburguer Rei', registration_number: '97311218000107', full_address: 'Avenida Contorno Sul, 202', city: 'São Paulo', state: 'SP', phone_number: '11900000000', email: 'contato@hambuguer.com', user: user)
    dish = Dish.create!(name: 'Canja de frango', description: '100g de Canja de frango blabla', calories: 100, restaurant: restaurant,photo: attach_image)
    
    login_as user 
    visit root_path
    click_on 'Meus Pratos'
    click_on dish.name 
    click_on 'Editar'
    click_on 'Adicionar Marcador'
    fill_in 'Descrição', with: 'Tag 1'
    click_on 'Enviar'
    
    expect(page).to have_content 'Tag 1'
  end
end