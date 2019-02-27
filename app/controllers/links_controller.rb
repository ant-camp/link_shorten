class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def show
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to @link, notice: "Link has been created and shortened"
    else
      redirect_to root_path
    end
  end

  def forward_to_link
    @link = Link.find(params[:id])
    if @link.expired?
      #if link expired returns true return 404
    else
      #this causes N+1 Query
      @link.stat.clicks_counter
      #redirect to url
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
