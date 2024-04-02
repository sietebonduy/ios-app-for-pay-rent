class Bill
  attr_accessor :id, :contract_id, :rent, :electricity, :garbage, :cold_water, :hot_water, :total

  def initialize(params={})
    @id = params[:id]
    @contract_id = params[:contract_id]
    @rent = params[:rent]
    @electricity = params[:electricity]
    @garbage = params[:garbage]
    @cold_water = params[:cold_water]
    @hot_water = params[:hot_water]
    @total = @rent + @electricity + @garbage + @cold_water + @hot_water
  end

  def paid
    @rent = 0
    @electricity = 0
    @garbage = 0
    @cold_water = 0
    @hot_water = 0
    @total = @rent + @electricity + @garbage + @cold_water + @hot_water
  end
end
