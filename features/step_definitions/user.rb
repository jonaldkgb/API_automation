class User

  attr_accessor :address, :first_name, :last_name

  def initialize
    @first_name = 'thisnew'
    @last_name = 'guy'
    @address = [UserAddress.new]
  end
end