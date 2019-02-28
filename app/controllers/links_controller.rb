class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  def new
    @link = Link.new
  end

  def show
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to @link, notice: "Link has been created and shortened."
    else
      redirect_to root_path
    end
  end

  def forward_to_link
    @link = Link.get_url!(params[:hash_key])
    if @link.expired?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    else
      @link.click_counter
      redirect_to @link.original_url, status: :moved_permanently
    end
  end


  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original_url)
  end

end
