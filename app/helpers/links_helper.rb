module LinksHelper
  def short_link_display(shortened_url)
    #Wont work for Prod will need to refactor
    #but for time being lets go with this
    "http://localhost:3000/#{shortened_url}"
  end
end
