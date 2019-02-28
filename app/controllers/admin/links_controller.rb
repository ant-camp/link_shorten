class Admin::LinksController < ApplicationController
  before_action :set_link, only: [:show, :expire_link]

  def show
  end

  def expire_link
    @link.update_attribute(:expired, true)
    respond_to do |format|
      format.js { render layout: false}
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end


end
