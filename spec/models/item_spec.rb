require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'falso quando o nome é vazio' do 
        item = Item.new(name: '')

        item.valid?

        expect(item.errors.include? :name).to eq true
      end

      it 'falso quando decrição é vazia' do 
        item = Item.new(description: '')

        item.valid?

        expect(item.errors.include? :description).to eq true
      end

      it 'verdadeiro quando caloria é vazia' do 
        item = Item.new(calories: '')

        item.valid?

        expect(item.errors.include? :calories).to eq false
      end

      it 'verdadeiro quando caloria não é vazia' do 
        item = Item.new(calories: 100)

        item.valid?

        expect(item.errors.include? :calories).to eq false
      end
    end

    context 'numericality' do 
      it 'falso quando caloria não é um número' do 
        item = Item.new(calories: 'abc')

        item.valid?

        expect(item.errors.include? :calories).to eq true
      end

      it 'verdadeiro quando caloria é um número' do 
        item = Item.new(calories: '100')

        item.valid?

        expect(item.errors.include? :calories).to eq false
      end
    end 

    context 'inclusion' do 
      it 'falso quando bebida não inclui seu tipo alcoólico' do 
        beverage = Beverage.new(alcoholic: nil)

        beverage.valid? 

        expect(beverage.errors.include? :alcoholic).to eq true
      end

      it 'verdadeiro quando bebida inclui seu tipo alcoólico' do 
        beverage = Beverage.new(alcoholic: true)

        beverage.valid? 

        expect(beverage.errors.include? :alcoholic).to eq false
      end
    end

    context 'acceptable_image' do 
      it 'falso quando a imagem não é JPEG ou PNG' do 
        item = Item.new
        item.photo.attach(io: File.open(Rails.root.join('spec/fixtures/image.txt')), filename: 'image.txt', content_type: 'image/plain')
      
        item.valid?

        expect(item.errors.include? :photo).to eq true
        expect(item.errors[:photo]).to include("deve ser JPEG ou PNG")
      end

      it 'verdadeiro quando a imagem é JPEG ou PNG' do 
        item = Item.new
        item.photo.attach(io: File.open(Rails.root.join('spec/fixtures/image.png')), filename: 'image.png', content_type: 'image/png')
      
        item.valid?

        expect(item.errors[:photo]).to be_empty
      end

      it 'falso quando a imagem é vazia' do 
        item = Item.new 
        
        item.valid?

        expect(item.errors.include? :photo).to eq true
        expect(item.errors[:photo]).to include("não deve ser vazia")
      end
    end
  end
end
