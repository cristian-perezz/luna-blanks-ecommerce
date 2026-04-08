class CartController < ApplicationController
  def show
    @cart_items = cart_products
  end

  def add
    session[:cart] ||= {}
    id = params[:product_id].to_s
    session[:cart][id] = (session[:cart][id] || 0) + 1
    redirect_to cart_path, notice: "Added to cart!"
  end

  def remove
    session[:cart]&.delete(params[:product_id].to_s)
    redirect_to cart_path, notice: "Removed from cart."
  end

  private

  def cart_products
    return [] unless session[:cart].present?
    session[:cart].filter_map do |id, qty|
      product = Product.find_by(id: id)
      { product: product, quantity: qty } if product
    end
  end
end