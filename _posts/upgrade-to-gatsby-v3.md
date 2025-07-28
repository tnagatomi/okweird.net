+++
title = 'Gatsbyをv3にアップグレードしてgatsby-blog-starterもアップグレードした'
date = 2021-03-11T17:30:00+09:00
draft = false
+++

表題のとおりです。

https://okweird.net は[Gatsby](https://www.gatsbyjs.com/)と[gatsby-blog-starter](https://www.gatsbyjs.com/starters/gatsbyjs/gatsby-starter-blog)をベースに構築しており、基本的には[Gatsby公式移行ガイド](https://www.gatsbyjs.com/docs/reference/release-notes/migrating-from-v2-to-v3/)に書かれていることをやっていけばGatsby v2からv3へのアップグレードができるのですが、それ以外の作業も必要だったのでログを残しておこうと思います。

## 作業ログ

```shell
$ npm install gatsby@latest
```

まずはメインであるGatsbyのアップグレードを行います。
僕の場合、`2.31.1` から `3.0.4` まで上がりました。

```shell
$ npm outdated
```

古い依存をリストします。
僕の場合、結果はこのような感じでした。

```
Package                          Current   Wanted  Latest  Location
gatsby-image                       2.5.0   2.11.0   3.0.0  gatsby-starter-blog
gatsby-plugin-feed                 2.7.0   2.13.1   3.0.0  gatsby-starter-blog
gatsby-plugin-google-gtag          2.6.0    2.8.0   3.0.0  gatsby-starter-blog
gatsby-plugin-manifest             2.6.1   2.12.1   3.0.0  gatsby-starter-blog
gatsby-plugin-offline              3.4.0   3.10.2   4.0.0  gatsby-starter-blog
gatsby-plugin-react-helmet         3.4.0   3.10.0   4.0.0  gatsby-starter-blog
gatsby-plugin-sharp                2.8.0   2.14.3   3.0.1  gatsby-starter-blog
gatsby-remark-copy-linked-files    2.4.0   2.10.0   3.0.0  gatsby-starter-blog
gatsby-remark-images               3.5.1   3.11.1   4.0.0  gatsby-starter-blog
gatsby-remark-prismjs              3.7.0   3.13.0   4.0.0  gatsby-starter-blog
gatsby-remark-responsive-iframe    2.5.0   2.11.0   3.0.0  gatsby-starter-blog
gatsby-remark-smartypants          2.4.0   2.10.0   3.0.0  gatsby-starter-blog
gatsby-source-filesystem           2.5.0   2.11.1   3.0.0  gatsby-starter-blog
gatsby-transformer-remark         2.10.0   2.16.1   3.0.0  gatsby-starter-blog
gatsby-transformer-sharp           2.6.0   2.12.1   3.0.0  gatsby-starter-blog
prismjs                           1.22.0   1.23.0  1.23.0  gatsby-starter-blog
react                            16.13.1  16.14.0  17.0.1  gatsby-starter-blog
react-dom                        16.13.1  16.14.0  17.0.1  gatsby-starter-blog
react-helmet                       5.2.1    5.2.1   6.1.0  gatsby-starter-blog
typeface-merriweather             0.0.72   0.0.72  1.1.13  gatsby-starter-blog
typeface-montserrat               0.0.75   0.0.75  1.1.13  gatsby-starter-blog
```

公式ガイドでは1つ1つ `npm install {package}@latest` するように書かれていますが、大変なので依存を最新にしてくれる `npm-check-updates` を使います。

```shell
$ npm install -g npm-check-updates
```

`npm-check-updates` のインストール。

```shell
$ ncu -u
```

`package.json` を最新のパッケージにアップグレード。

```shell
$ npm install
```

実際にパッケージをインストール。

```shell
$ npm outdated
```

ここで再度チェックしてみたところ、僕の場合は `gatsby-image` が残っていました。

```
Package       Current  Wanted  Latest  Location
gatsby-image    2.5.0  2.11.0   3.0.0  gatsby-starter-blog
```

```shell
$ npm install gatsby-image@latest
```

`gatsby-image` をアップグレードします。

ここで `gatsby develop` をすると以下のようなPostCSS関連のエラーが出ました。

```
Error: PostCSS plugin postcss-flexbugs-fixes requires PostCSS 8.
Migration guide for end-users:
https://github.com/postcss/postcss/wiki/PostCSS-8-for-end-users
```

そのため、PostCSS関連も[PostCSS公式の移行ガイド](https://github.com/postcss/postcss/wiki/PostCSS-8-for-end-users#gatsby)にしたがってアップグレードします。

```shell
$ npm install gatsby-plugin-postcss
npm install postcss
```

次は

`warn [gatsby-transformer-sharp] The "fixed" and "fluid" resolvers are now deprecated. Switch to "gatsby-plugin-image" for better performance and a simpler API. See https://gatsby.dev/migrate-images to learn how.`

というメッセージが出ていたため `gatsby-plugin-image` を使うようこちらも[公式移行ガイド](https://www.gatsbyjs.com/docs/reference/release-notes/image-migration-guide/)に従いアップグレードします。

```shell
$ npm install gatsby-plugin-image gatsby-plugin-sharp gatsby-transformer-sharp
```

関連するプラグインをインストールします。

```shell
$ npx gatsby-codemods gatsby-plugin-image
```

`gatsby-plugin-image` 用にコードを自動的に修正してくれます。

このあと必要な場合は手動で修正を行います。僕の場合は必要ありませんでした。

以上で `gatsby develop` を行ったらエラーなしに表示されるようになりました！

## 最後に

あまりGatsbyもNodeパッケージ周りも詳しくないため無駄があるかもしれません。もっとこうした方がいい点があればご指摘いただければと思います。

それでは良いGatsbyライフを！
