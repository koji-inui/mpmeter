class UsersController < ApplicationController
  def show 
    @user = User.find(current_user.id)
    @name = current_user.email
    #@today_mp = current_user.conditions.order(:cday DESC ).first.mp
    @today_mp = current_user.conditions.order("cday DESC ").first.mp
    @today_st = current_user.conditions.order("cday DESC ").first.sleep_time
    @today_ej = current_user.conditions.order("cday DESC ").first.eja_times
    @today_condition = choushi(@today_mp)
    @tomorrow_mp = forecast(@today_mp,@today_st,@today_ej)
    @tomorrow_condition = choushi(@tomorrow_mp)

#    binding.pry
#    @akashi =  JSON.pretty_generate(JSON.parse(response.read)) 
  end



  def destroy
#    @conditions = current_user.conditions.where(user_id: current_user.id) 
  end

   private
    def choushi(today_mp)
      if today_mp == 1
        today_condition = '絶不調'
      elsif today_mp == 2
        today_condition = 'ちょっと不調'
      elsif today_mp == 3
        today_condition = 'まあまあ'
      elsif today_mp == 4
        today_condition = '好調'
      else 
        today_condition = '絶好調'
      end

      return today_condition

    end

    def forecast(mp,st,ej)
      if st > 8.0
        st_add = 2
      elsif st  > 7.0
        st_add = 1
      elsif st  > 5.0
        st_add = 0
      elsif st  > 3.0
        st_add = -1
      else
        st_add = -2
      end

      tomorrow_mp =  mp + st_add - ej
      return tomorrow_mp

    end



end
