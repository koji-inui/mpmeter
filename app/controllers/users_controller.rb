class UsersController < ApplicationController
  def show 

    require "json"
    require "open-uri"
    api_key = "e1a6dfa87fed1ea45838113bbdea6cf7"
    base_url = "http://api.openweathermap.org/data/2.5/forecast/daily"
    #response = open(base_url + "?q=Tokyo,jp&units=metric&APPID=#{api_key}")
    response = open(base_url + "?id=1850147&units=metric&APPID=#{api_key}")
    @tenki = JSON.parse(response.read)

    @user = User.find(current_user.id)
    @name = current_user.email
    #@today_mp = current_user.conditions.order(:cday DESC ).first.mp
    today_mp = current_user.conditions.order("cday DESC ").first.mp
    today_st = current_user.conditions.order("cday DESC ").first.sleep_time
    today_ej = current_user.conditions.order("cday DESC ").first.eja_times
    today_tk = current_user.conditions.order("cday DESC ").first.temperature
    @today_condition = choushi(today_mp)

    tomorrow_tk = @tenki["list"][1]["temp"]["day"]

    tomorrow_mp = forecast(today_mp,today_st,today_ej,today_tk,tomorrow_tk)
    @tomorrow_condition = choushi(tomorrow_mp)

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
      elsif today_mp == 5
        today_condition = '絶好調'
      else 
        today_condition = 'よくわからない'
      end

      return today_condition

    end

    def forecast(mp,st,ej,t_toda,t_tomo)
      if st > 8.0
        st_add = 2
      elsif st  > 6.5
        st_add = 1
      elsif st  > 5.0
        st_add = 0
      elsif st  > 3.5
        st_add = -1
      else
        st_add = -2
      end

      tomorrow_mp += 1 if ej == 0

      tomorrow_mp =  mp + st_add - ej

      if (t_tomo - t_toda).abs > 8.0
        tomorrow_mp -= 1
      end

      if tomorrow_mp < 1
        tomorrow_mp = 1
      elsif tomorrow_mp > 5
        tomorrow_mp = 5
      end

      return tomorrow_mp

    end



end
