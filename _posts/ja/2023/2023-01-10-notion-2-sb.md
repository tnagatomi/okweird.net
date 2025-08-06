---
title: 単一NotionページをScrapboxページ用テキストに変換するNode.jsツール、notion2sbを作った
date: '2023-01-10T21:00:00+09:00'
draft: false
---

最近はGoのCLIツールを[作ったり](https://okweird.net/blog/first-go-oss-product)、[学んだり](https://okweird.net/blog/powerful-go-cli-app)するのが一番楽しいと思う今日この頃なのですが、ふとNode.jsとTypeScriptでもCLIツールを作れないかと思い立ちました。

何かネタはないかな〜と思っているうち、そういえばScrapboxもNotionもよく使うのだけど、Scrapbox→Notionの記事などはあっても、逆のNotion→Scrapboxのものはあまり無いなぁと気づいたのでした。

そこで出来たのがnpmパッケージとして公開した、[notion2sb](https://www.npmjs.com/package/@tommy6073/notion2sb)というツールです。

## 何をするツール？

名前は[pastak](https://github.com/pastak)さんの[md2sb](https://github.com/pastak/scrapbox-converter/tree/master/packages/md2sb)にならっています。  
md2sbはMarkdownをScrapboxテキストにエンコードするツールですが、md2sbがMarkdown→Scrapboxなら、notion2sbはNotion→Scrapboxというわけです。

そして、実際のところ、名前だけでなく、ほとんどの処理をmd2sbに委譲しています。  
どういうことかというと、READMEにも書いていますが、notion2sbがやっているのは、NotionからMarkdownとしてエクスポートされた単一ファイルを、md2sb互換のものに変換し、md2sbにそれを渡しているというものです。  
具体的には、Notionの数式記法などは、そのままmd2sbに渡すとエンコードされないため、notion2sbにて事前変換を行っています。

それに加えて、ページ中の画像を抽出し、[shokai](https://github.com/shokai)さんの[gyazo-api](https://www.npmjs.com/package/gyazo-api)を利用してGyazoにアップロードし、画像リンクをGyazoのURLに置換するということも行っています。  
そのおかげで、Notionのページに貼ってあった画像を、そのまま変換されたScrapboxのページでも表示することが可能となります。

この通り、やっていることとしてはそんなに大きくないツールです。実際、行数としても100行程度です。

## 何を学べたか

このツールの作成を通じて、何を学べたか書いてみます。

- 慣れないTypeScriptを、WebStormに怒られつつ、型を付けながら書いて学ぶことが出来た。
- Node.jsでのCLIツールの作り方の初歩を覚えた。
- tsconfig.jsonなどを調整し、モジュールを、古いものも含めて、互換性を保ちながらインポートする方法を学んだ。
- npmパッケージの公開の仕方が分かった（やってみるとめちゃ簡単！）。
- NotionやScrapboxのテキスト形式をより知ることが出来た。
- Gyazo APIの挙動を知ることが出来た。

けっこう学べましたね。こんな小さなツールでも、実際に手を動かすと色々なことが学べるという良い例かもしれません。

## 今後どうしたいか

さて、この小さなツールですが、まだまだ未完成なので、次のようなことをやっていきたいです。

- md2sb互換のMarkdownに変換しきれていない部分も多い（リストなどのブロックが空ブロックを挟まずに連続していると乱れる、など）ため、改善したい。  
- 複数ページ変換機能
  - 単一ページにしか対応していないため、ゴソッと複数ページをバルクで変換する機能も追加したい。具体的には、インポートしやすいようにScrapbox用のJSONファイルに変換することになりそう。
  - 変換したページへのリンクを維持したまま繋げられるようにする。
  - 複数ページを変換する際に、ページ名が被った時の処理を考える。

## まとめ

というわけで、[notion2sb](https://www.npmjs.com/package/@tommy6073/notion2sb)の紹介と、その作成を通じて思ったことを書いてみました。

アイデアを形にするまで、それほど時間はかかりませんでしたが、洗練度を上げることにこそプログラミングの本質があるのかもしれないという意味で言えば、まだまだ未完成なものだと思います。

機会があれば、改善を重ねていきたいです。
