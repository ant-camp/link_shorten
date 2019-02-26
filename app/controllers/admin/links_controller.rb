class Admin::LinksController < ApplicationController
  def show
  end

  def expire_link
    @link.update_attribute(:expired, true)
    # redirect_to notice: "You have expired the link"
    #figure out the correct page to redirect to
  end

  private

  def link_params
    params.require(:link).permit(:original_url, :expired)
  end
end
