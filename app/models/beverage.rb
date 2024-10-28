class Beverage < Item 
  validates :alcoholic, inclusion: { in: [true, false], message: "Deve informar se a bebida é alcoólica ou não" }
end