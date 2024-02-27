require_relative 'user'

class Dealer < User
  def initialize
    @name = "Dealer"
    super(@name)
  end
end