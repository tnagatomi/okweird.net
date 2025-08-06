---
title: Ruby on RailsとParklifeで静的サイトを構築する
date: '2025-07-28T16:50:00+09:00'
---

この記事ではRuby on Railsで静的サイトを構築する方法を紹介します。Parklifeというツールの力を借ります。

### Parklifeとは

[Parklife](https://parklife.dev/) とは、公式サイトの言葉を借りると下記のようなツールです:

> Parklife is a Ruby library to render a Rack app (Rails/Sinatra/etc) to a static build ready to be served by GitHub Pages, Netlify, S3, Vercel, or any other server.

要するにRailsなどのRackアプリを静的ビルドできますよーというものです。

僕はBen Sheldonさんの[Living Parklife with Rails, coming from Jekyll \| Island94.org](https://island94.org/2025/01/living-parklife-with-rails-coming-from-jekyll)という記事を読んでこのツールの存在を知りました。  
仕事でもRails書いてるし、個人サイトもRailsで書けるなら書いてみるかーとなったところ、Hugoで書いていたサイトをうまくすんなり移行させることができました。

### やること

やることは単純で、普通にRailsアプリを書いて、コントローラーとビューに吐き出させたものをParklifeにコマンドでクロールさせてビルドするだけです。  
ParklifeにはGitHub Pages用のGitHub Actionsのワークフローの生成機能もついているので楽ちんです。

書くのはRailsアプリそのものなので、モデルやヘルパーは思いのままです。また、テストもいつもと同じ感覚で書けます。  
僕の場合は主にMarkdownのポストをHTML出力するブログ用のMVCをkramdown-parser-gfmやfront_matter_parserなどを使って書きました。  
今は主にブログぐらいしかないですが、もっと色んなページで充実させてみたいと思わせてくれています。

### 参考になる記事とリポジトリ

サイトを構築するにあたって、Ben Sheldonさんの先ほどのブログ記事と[彼のサイトのリポジトリ](https://github.com/bensheldon/island94.org)が超参考になりました。  
下手にサンプルコードを用意するより、このリポジトリを見て自分なりにアレンジしてみるとうまくいくと思います。

### まとめ

皆さんもこの記事を読んで興味を持っていただけたら、Railsで静的サイトを作ってみてはいかがでしょうか。
Happy railing!
