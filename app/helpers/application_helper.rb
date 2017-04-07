module ApplicationHelper
  def previous_path(options = {})
    path = if cookies[:referer_url]
      cookies[:referer_url]
    else
      root_path
    end

    uri = URI.parse(path)
    new_query = URI.decode_www_form(uri.query || '') + options.to_a
    uri.query = URI.encode_www_form(new_query)
    uri.to_s
  end
end
