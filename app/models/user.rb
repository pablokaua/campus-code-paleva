class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :restaurant

  validates :name, :last_name,:cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validated

  def cpf_validated 
    unless CPF.valid?(cpf)
      errors.add(:cpf, "inválido")
    end
  end
end
