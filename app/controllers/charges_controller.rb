class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attributes(role: 'premium')

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_path

    #Stripe will send back CardErrors, with friendly messages when something goes wrong.
    #This rescue block catches and displays errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def destroy
    current_user.update_attributes(role: 'standard')

    wikis = current_user.wikis
    wikis.each do |w|
      w.update(private: false)
    end

    flash[:notice] = "You have been downgraded. You private wikis are now public."
    redirect_to root_path
  end
end
