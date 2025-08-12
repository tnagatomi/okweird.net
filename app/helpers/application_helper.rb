module ApplicationHelper
  def language_switch_links
    aria_label = I18n.locale == :ja ? "言語選択" : "Language selection"

    content_tag(:nav, class: "language-switcher", "aria-label": aria_label) do
      if I18n.locale == :ja
        safe_join([
          link_to("English", switch_locale_path(:en),
                  class: "other-lang",
                  lang: "en",
                  hreflang: "en",
                  title: "英語版に切り替え"),
          content_tag(:span, "日本語",
                     class: "current-lang",
                     lang: "ja",
                     "aria-current": "true")
        ], " / ")
      else
        safe_join([
          content_tag(:span, "English",
                     class: "current-lang",
                     lang: "en",
                     "aria-current": "true"),
          link_to("日本語", switch_locale_path(:ja),
                  class: "other-lang",
                  lang: "ja",
                  hreflang: "ja",
                  title: "Switch to Japanese Version")
        ], " / ")
      end
    end
  end

  def switch_locale_path(locale)
    current = request.path

    if locale == :ja
      return "/ja/" if current == "/"
      return "/ja/blog/" if current == "/posts/" || current == "/posts"
      return "/ja/history/" if current == "/history/" || current == "/history"
      if current.match?(/^\/posts\/\d{4}\/\d{2}\//)
        return "/ja/blog/"
      end
      return "/ja#{current}" unless current.start_with?("/ja/")
      current
    else
      return "/" if current == "/ja/" || current == "/ja"
      return "/posts/" if current == "/ja/blog/" || current == "/ja/blog"
      return "/history/" if current == "/ja/history/" || current == "/ja/history"
      if current.match?(/^\/ja\/blog\/\d{4}\/\d{2}\//)
        return "/posts/"
      end
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
