class PagesController < ApplicationController
  layout 'pages'
  layout 'application', :only => [ :unavailable_content ]

  def unavailable_content
  end
end
