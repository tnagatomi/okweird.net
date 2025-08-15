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
    current = request.path == "/" ? "/" : "#{request.path}/"

    if locale == :ja
      return "/ja/posts/" if current.start_with?("/en/posts") || current.start_with?("/posts")
      return current.sub(/^\/en/, "ja") if current.start_with?("/en/")

      "/ja#{current}"
    else
      return "/posts/" if current.start_with?("/ja/posts")

      current.sub(/^\/ja/, "").presence || "/"
    end
  end
end
