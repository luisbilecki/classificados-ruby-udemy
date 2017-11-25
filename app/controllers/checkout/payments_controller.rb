class Checkout::PaymentsController < ApplicationController
  def create

    ad = Ad.find(params[:ad_id])
    ad.processing!

    order = Order.create( ad: ad, buyer_id: current_member.id )
    order.waiting!

    payment = PagSeguro::PaymentRequest.new

    payment.reference = order.id
    payment.notification_url = checkout_notifications_url  # FIX LATER
    payment.redirect_url = site_ad_detail_url(ad) # http://localhost:300/site/ad_detail/25

    payment.items << {
        id: ad.id,
        description: ad.title,
        amount: ad.price.to_s.gsub(',' , '.')
    }

    response = payment.register

    if response.errors.any?
        redirect_to site_ad_detail_path(ad), alert: "Erro ao processar compra.
         Entre em contato com o SAC (xx) xxx.xxxx"
    else
        redirect_to response.url
    end
  end
end
