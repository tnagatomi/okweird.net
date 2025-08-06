module ApplicationHelper
  def language_switch_links
    if I18n.locale == :ja
      content_tag(:span, class: "language-switcher") do
        link_to("en", switch_locale_path(:en), class: "other-lang") + " / " + content_tag(:span, "ja", class: "current-lang")
      end
    else
      content_tag(:span, class: "language-switcher") do
        content_tag(:span, "en", class: "current-lang") + " / " + link_to("ja", switch_locale_path(:ja), class: "other-lang")
      end
    end
  end

  def switch_locale_path(locale)
    current = request.path
    
    if locale == :ja
      return "/ja/" if current == "/"
      return "/ja/blog/" if current == "/posts/" || current == "/posts"
      return "/ja/history/" if current == "/history/" || current == "/history"
      return "/ja#{current}" unless current.start_with?("/ja/")
      current
    else
      return "/" if current == "/ja/" || current == "/ja"
      return "/posts/" if current == "/ja/blog/" || current == "/ja/blog"
      return "/history/" if current == "/ja/history/" || current == "/ja/history"
      current.sub(/^\/ja/, "").presence || "/"
    end
  end

  def localized_root_path
    I18n.locale == :ja ? "/ja/" : "/"
  end

  def localized_posts_path
    I18n.locale == :ja ? "/ja/blog/" : "/posts/"
  end

  def localized_history_path
    I18n.locale == :ja ? "/ja/history/" : "/history/"
  end
end
