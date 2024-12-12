+++
title = 'Rubyプログラムの対話型デバッグのこれまでとこれから'
date = 2024-12-13T05:30:00+09:00
+++

## はじめに

この記事は[SmartHR Advent Calendar 2024](https://qiita.com/advent-calendar/2024/smarthr) シリーズ1の13日目です。『Rubyプログラムの対話型デバッグのこれまでとこれから』と題して書きます。

この話を書こうと思ったのにはきっかけがあります。[プロダクト開発中に見つけた問題を修正して初めてRuby on Railsにコントリビュートしました！ 〜「OSSやっていきの集い」活動報告〜 - SmartHR Tech Blog](https://tech.smarthr.jp/entry/2024/10/31/145021)という会社のテックブログを執筆中に、「binding.pryを使ってブレークポイントを設定しました」と書いていたところ、レビューで同僚に「binding.pryは使っていなくて使ったのはbinding.irbですよ」と指摘されました。

そういやこの辺りのRubyプログラムの対話型デバッグに使えるツール群についてよく分かっていないなということに気づいたので、調べるついでにまとめてみようというのが発端になって書いた記事です。

注意として、Web上の情報を元に書いたもので、僕自身の経験に基づいて書いた記事ではないですし、書いていることに間違いがあるかもしれません。その場合は指摘していただけると嬉しいです。

## Rubyプログラムの対話型デバッグに関わるツール郡

まずはRubyプログラムの対話型デバッグに関わるツールにどのようなものがあって、どのように使われているのか調べてみることにしました。

どのようなものがあるかとしては、このような形にまとめられそうです:

- 対話型コンソールとして、主に2つがある
  - Ruby標準の[IRB](https://github.com/ruby/irb)
  - サードパーティの[Pry](https://github.com/pry/pry)
- デバッガーとして、主に3つある
  - Ruby標準の[debug.gem](https://github.com/ruby/debug)
  - サードパーティの[Byebug](https://github.com/deivid-rodriguez/byebug)
  - サードパーティの[debase](https://github.com/ruby-debug/debase)

そして、`binding.irb` や `binding.pry` などの行をプログラム中に挟んで、その行でデバッグコンソールを開くやり方が広く行われています。

## Rubyプログラムの対話型デバッグのこれまでとこれから

では現状はどうなっているかというと、古くからサードパーティのPry + Byebug（[pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)）を組み合わせた対話型デバッグが主流でしたが、Ruby 3.1ぐらいにかけてIRBに不足していたPryの機能がIRBに取り込まれ、更にdebug.gemの登場により、両方ともRuby標準であるIRBとdebug.gemを組み合わせるやり方が勢いを見せているようです。  
なお、ここまで名前が登場しなかったdebaseはRubyMineで使われています。

このIRBとdebug.gemと現状については、それぞれのコントリビューターの記事を読んでみると理解が進むと思います。

IRBについては実際にPryのヘビーユーザーでもありIRBへ機能を持ち込んだ本人でもあるk0kubunさんがその進化を語っています:  
[Pryはもう古い、時代はIRB - k0kubun's blog](https://k0kubun.hatenablog.com/entry/2021/04/02/211455)

この記事から、Pryだけにあった機能がIRBに取り込まれていった様子が分かるかと思います。

debug.gemについてはRuby 3.1での導入時に笹田さんが書かれたブログがあります:  
[Ruby 3.1 の debug.gem を自慢したい - クックパッド開発者ブログ](https://techlife.cookpad.com/entry/2021/12/27/202133)

Stan LoさんによるByebugとの比較記事もあります:  
[Ruby: byebugからruby/debugへの移行ガイド（翻訳）｜TechRacho by BPS株式会社](https://techracho.bpsinc.jp/hachi8833/2022_09_01/121134)

この2つの記事から、Byebugの開発が鈍る一方で、debug.gemがとても充実していっている様子が分かるかと思います。

また、Ruby on Railsだとどうかというと、debug.gemはRails 7からデフォルトのデバッガーになっており、Rails Guidesでも[Debugging with the debug Gem](https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem)というセクションがあり、debug.gemの `binding.break` を使う方法が紹介されています。

このように見てみると、IRBとdebug.gemが本当の意味でも標準になっていっているように見えます。

余談として、個人的なところだと、この組み合わせで、`bidning.irb` と `binding.break` という2つのブレークポイント、`irb` と `rdbg` という2つのモードを、どのように使い分ければ良いのかまだあまり分かっていません。お互いにコマンドを通じて行き来できるような作りになっていて、相互に持っていない機能を持っているというところまでは理解できています。この辺は実際に使いながら身につけていきたいなと思いました。

## まとめ

ここまででRubyの対話型デバッグのこれまでとこれからについて簡単なまとめを書いてみました。  
標準のIRBとdebug.gemの進化、とても頼もしいですね。  
PryやByebugにもこんな利点があるよとか、こんなツールもあるよみたいなところがあれば、ぜひ教えていただきたいです。

最後に、このように標準ツールが改善されたのは、お互いに良いところを取り込み続けた結果なのだと思います。  
今まで貢献してくれた方々に敬意を払いつつ、これらのツールを使っていきたいと思いました。
