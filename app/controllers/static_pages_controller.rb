class StaticPagesController < ApplicationController

	def home
	    @activities         = Activity.all
	    #@trip               = Trip.first
	    @everest_trek       = Trip.find_by_id(7)
	    @langtang_trek      = Trip.find_by_id(9)
	    @manaslu_trek       = Trip.find_by_id(8)
      @apex_longs_2_day   = Trip.find_by_id(12)
      @apex_longs_1_day   = Trip.find_by_id(13)
      @apex_basic_rock    = Trip.find_by_id(10)
      @tenmile_mb         = Trip.find_by_id(16)
      @tenmile_fly        = Trip.find_by_id(14)
      @tenmile_mb_group   = Trip.find_by_id(17)
	end

  def after_signup
  end
  
  def faqs
    @trip = Trip.find_by_id(17)
  end

	private


end
