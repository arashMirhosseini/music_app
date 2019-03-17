module ApplicationHelper
  include ERB::Util

  def auth_token
    "<input
    type=\"hidden\"
    name=\"authenticity_token\"
    value=\'#{form_authenticity_token}\'/>".html_safe
  end

  def ugly_lyrics(lyrics)
    lyrics_arr = lyrics.lines
    str = ""
    lyrics_arr.each do |line|
      str << "&#9835; #{h(line)}"
    end

    "<pre>#{str}</pre>".html_safe

  end
end
