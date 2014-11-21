class UserMailer < ActionMailer::Base
  before_action :get_coelevation
  default from: "noreply@coelevation.com"

  def purchase_confirmation(user, order)
  	@user = user
  	@order = order
  	@order_items = @order.order_items.all(:include => :trip_date, :order => 'trip_dates.start_date ASC')
  	mail(:to => @user.email, :subject => "Trip Confirmation")
  end

  def order_change_confirmation(user, order_item)
  	@user = user
  	@order_item = order_item
  	mail(:to => @user.email, :subject => "Your trip has been updated")
  end

  def resend_trip_details(user, order_item)
    @user = user
    @order_item = order_item
    mail(:to => @user.email, :subject => "Your trip details")
  end

  def guide_purchase_alert(order_item)
    @client = order_item.client
    @guide = order_item.guide
    @order_item = order_item
    mail(:to => @guide.email, :subject => "You have a new trip.")
  end

  def guide_order_change_alert(order_item)
    @client = order_item.client
    @guide = order_item.guide
    @order_item = order_item
    mail(:to => @guide.email, :subject => "You have a new trip.")
  end

  def company_purchase_alert(order_item)
  end

  def company_order_change_alert(order_item)
  end

  def request_confirmation(trip, request)
    @admin = User.where(:admin => true)
    @trip = trip
    @request = request
    mail(:to => [request.email, @admin.pluck(:email)], :subject => "Request received")
  end
  
  private
  
    def get_coelevation
      @ce = Company.find_by_id(4)
    end

end
