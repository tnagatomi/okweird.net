+++
title = '個人Webアプリ作成という荒野に立った'
date = 2021-04-13T23:14:00+09:00
draft = false
+++

[const writeWebAppWithStrongWill = true;](https://okweird.net/blog/write-web-app-with-string-will/) で宣言したとおり、Webアプリ作りに着手している。

技術スタックは所属するペパボ ホスティング事業部でこれから使っていくものに沿っていく方針。ひとまずTypeScriptとNext.jsを使うことは確定している。

アプリの肝となるノードを描画するUIが必要なので色々と検討した結果、https://github.com/wbkd/react-flow を使うことに決めた。この辺のライブラリー、ドキュメントがあまり充実していないので使いながら覚えていくしかなさそう。

ノードUIライブラリも決まったので、ひとまず `npx create-next-app` したあと、ESLintとPrettierを導入したところまで進めた。ルール多すぎてどう設定したらいいか分からん状態だったけど、そのことをTwitterでつぶやいたらアドバイスいただけて、ESLintとPrettierの共存方法が分かり、ESLintはrecommendedを使ってルールはあとから追加していく形で良さそうと分かった。

次はMaterial-UIを導入しようとしているのだけど、Next.jsのCustom AppやらCustom Documentが分からん、むしろNext.js何も分からん状態になっている。
ReactとNext.jsは半年ほど前に1回チュートリアルをやったのだけど、完全に忘れてしまっているのでもう1周しようと思い、ひとまずReactのチュートリアルを終えた。  
モダンなReactの書き方を教えてくれるヘルシンキ大学の [Full stack open](https://fullstackopen.com/en/) もまた1周するか迷っているところ。

学習しながら作るの、体系的に学ぶ癖のある僕にはさじ加減が難しいのだけど、最初から全部を把握することは諦めたほうがいいだろうし、あまりチュートリアル煉獄には陥りたくないので、つまみ食いしながらアプリを作っていきたいと思う。

やってくぞー。
