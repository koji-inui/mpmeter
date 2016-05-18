class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show, :update]
  before_action :set_condition_destroy, only: [:destroy, :edit]
  before_action :move_to_index, except: :index

  # GET /conditions
  # GET /conditions.json
  def index
    @conditions = Condition.all
#    cdays = @conditions.map{|condition| condition.cday.strftime("%Y-%m-%d")}
    cdays = @conditions.map{|condition| condition.cday}
    mps = @conditions.map{|condition| condition.mp}
    tickinterval = 2
    
#    category = [1,3,5,7]
#    current_quantity = [1000,5000,3000,8000]
#    current_quantity2 = [1000,5000,3000,8000,1000,5000,3000,8000]
#    @graph = LazyHighCharts::HighChart.new('graphhhhh') do |f|
#      f.title(text: 'aaaa')
#      f.xAxis(categories: category)
#      f.series(name: 'zaiko', data: current_quantity)
#    end
#    @data_mp = LazyHighCharts::HighChart.new('mpmp') do |f2|
#      f2.chart(type: 'spline')
#      f2.title(text: 'bbb')
#      f2.xAxis(type: 'datetime', dateTimeLabelFormats: {month: '%e. %b', year: '%b'} )
#      f2.xAxis(tickinterval: tickinterval)
#      f2.series(name: 'zaiko', data: current_quantity2)
#      f2.series(name: 'day', data: cdays )
#      f2.series(name: 'MP', data: mps )
#    end
  end

  # GET /conditions/1
  # GET /conditions/1.json
  def show
  end

  # GET /conditions/new
  def new
    require "json"
    require "open-uri"
    api_key = "e1a6dfa87fed1ea45838113bbdea6cf7"
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    response = open(base_url + "?id=1850147&units=metric&APPID=#{api_key}")
    tenki = JSON.parse(response.read)
    @today_temperature = tenki["main"]["temp"]
    @condition = Condition.new
  end

  # GET /conditions/1/edit
  def edit
  end

  # POST /conditions
  # POST /conditions.json
  def create
    @condition = Condition.new(user_id: current_user.id, cday: condition_params[:cday], mp: condition_params[:mp], hp: condition_params[:hp], temperature: condition_params[:temperature], sleep_time: condition_params[:sleep_time],eja_times: condition_params[:eja_times],noting: condition_params[:noting])
    #Condition.create(user_id: current_user.id, cday: condition_params[:cday], mp: condition_params[:mp], hp: 2  )

    respond_to do |format|
      if @condition.save
        format.html { redirect_to "/users/#{@condition.user_id}", notice: 'Condition was successfully created.' }
    #    format.html { redirect_to @condition, notice: 'Condition was successfully created.' }
        format.json { render :show, status: :created, location: @condition }
      else
        format.html { render :new }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end

#    redirect_to "/users/#{@condition.user_id}"
  end

  # PATCH/PUT /conditions/1
  # PATCH/PUT /conditions/1.json
  def update
    respond_to do |format|
      if @condition.update(condition_params)
        format.html { redirect_to @condition, notice: 'Condition was successfully updated.' }
        format.json { render :show, status: :ok, location: @condition }
      else
        format.html { render :edit }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conditions/1
  # DELETE /conditions/1.json

  def destroy
    @condition.destroy
    respond_to do |format|
      format.html { redirect_to conditions_url, notice: 'Condition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition
      @condition = Condition.find(params[:id])
    end

    def set_condition_destroy
      @condition = Condition.find_by(cday: params[:day_for_delete])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condition_params
      params.require(:condition).permit(:user_id, :cday, :mp, :hp, :temperature, :whether, :sleep_time, :eja_times, :noting)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end
end
