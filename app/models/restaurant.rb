class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :beverages

  validates :code,:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :phone_number, :email, presence: true

  validates :registration_number, :corporate_name, :email, :user, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'inválido' } 
  validates :phone_number, length: {minimum: 10, maximum: 11, too_short: "deve ter no mínimo 10 caracteres", too_long: "deve ter no máximo 11 caracteres"} 
  validate :cnpj_validated

  before_validation :generate_code

  private
  def cnpj_validated 
    unless CNPJ.valid?(self.registration_number)
      self.errors.add(:registration_number, "inválido")
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
