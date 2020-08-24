class OrdersController < ApplicationController
  before_action :authenticate_user
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def add
    @item = Item.find_by(id: params[:id])
    @order = Order.new(user: current_user, item: @item, bought: false)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @item, notice: 'Successfully added to cart.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def myorders
    @orders = Array.new
    if logged_in?
      Order.all.each do |order|
        if order.user.id == current_user.id && order.bought
          @orders << (order)
        end
      end
    end
  end

  def cart
    @cart = Array.new
    if logged_in?
      Order.all.each do |order|
        if order.user.id == current_user.id && !order.bought
          @cart << (order)
        end
      end
    end
    return @cart
  end

#deletes all orders of specific item
  def delete
    if logged_in?
      @item = Item.find(params[:item_id])
      @order = Order.find_by(item: @item)
      @order.destroy
      redirect_to '/cart'
    end
  end

  def checkout
    @cart = Array.new
    if logged_in?
      Order.all.each do |order|
        if order.user.id == current_user.id && !order.bought
          @cart << (order)
        end
      end
    end
    @cart.each do |order|
      order.bought = true
      order.save
    end
    redirect_to '/'
  end

  def authenticate_user
    if !logged_in?
      redirect_to '/login'
    end
  end
end
