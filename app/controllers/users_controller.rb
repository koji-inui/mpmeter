class UsersController < ApplicationController
  def show 
    @user = User.find(current_user.id)
    @name = current_user.email
#    @conditions = current_user.conditions.where(user_id: current_user.id) 
#    binding.pry
#    @akashi =  JSON.pretty_generate(JSON.parse(response.read)) 
  end



  def destroy
#    @conditions = current_user.conditions.where(user_id: current_user.id) 
  end
end
