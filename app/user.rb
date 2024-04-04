class User
  attr_accessor :id, :name, :email, :password, :phone_number

  def initialize(params={})
    @id = params[:id] || nil
    @name = params[:name]|| nil
    @email = params[:email]|| nil
    @password = params[:password]|| nil
    @phone_number = params[:phone_number]|| nil
  end

  def log_out
    @name = nil
    @email = nil
    @password = nil
    @phone_number = nil
  end
end
