---
title: 書籍『Powerful Command-Line Applications in Go』でGoによるCLIツール作成のための「パワー！」をもらった
date: '2022-12-21T15:57:00+09:00'
draft: false
---

この記事は[🎅GMOペパボエンジニア Advent Calendar 2022](https://adventar.org/calendars/7722)の21日目の記事です。

## まず始めに: GoとCLIツールの相性の良さ

Goの主な用途にCLIツールを書くというのがあると思います。

シングルバイナリにコンパイルされることや、クロスコンパイルが容易なことから、[kubernetes/kubectl](https://github.com/kubernetes/kubectl)や[hashicorp/terraform](https://github.com/hashicorp/terraform)といった広く使われているCLIツールもGoで作成されています。

私も、[tommy6073/takolabel](https://github.com/tommy6073/takolabel)という、GitHubのlabelsを複数のリポジトリに跨って操作できるツールを作成したりしました（このツールが生まれた経緯についてはこちら: [初めてのGo製CLIツール作成、初めてのOSS公開に込められた物語](https://okweird.net/blog/first-go-oss-product)）。  

特に、Goで作成されたCLIツールのユーザーとして思うのは、依存関係を気にすることなく、バイナリ1発で実行できるというのが本当に強力だということです。

## そして『Powerful Command-Line Applications in Go』と出会った

さて、そんなこんなで、GoでのCLIツール作成技術を上げたいなと思っていたところ、redditの[r/golang](https://www.reddit.com/r/golang/)でこんなポストを発見しました:

[Is there a practical Golang entry point for experienced programmers? : golang](https://www.reddit.com/r/golang/comments/ycjdt1/is_there_a_practical_golang_entry_point_for/)

Pythonによる[Automate the Boring Stuff with Python](https://automatetheboringstuff.com/)に相当するGoの本はないかとの質問ポストでしたが、それに対するコメントの中に[Powerful Command-Line Applications in Go: Build Fast and Maintainable Tools](https://pragprog.com/titles/rggo/powerful-command-line-applications-in-go/)が紹介されていたのです。

発売時点ではRed HatでAutomation Consultantとして働いているRicardo Gerardiによる本とのことで良さそうと思い、早速買ってみて読んだところ、これが実際にとてもとても良い本だったのでした。

この本では、実際に動くCLIツールを、サンプルコードと共にテストを書きながら学びます。  
そのトピックは、ファイル、プロセス、REST API、インタラクティブなターミナルツール、SQLデータベースと広範囲です。そのことから、CLIツールに留まらず、Goでテスタブルな良いコードを書く方法を学ぶのにもうってつけです。

この記事では、その中から特に役に立つと思ったtipsを何個かご紹介します。気になった方は是非本を買ってみてください。

## 標準出力のテストにはio.Writerを使う

標準出力のテストってしづらいですよね。そこがio.Writerの出番です。  
テストしたい関数の引数に、io.Writerを指定し、実際の実行ではos.Stdoutを使い、テストではbytes.Bufferなどにキャプチャさせて比較させるのです。

ずいぶんと既知の方法ではありますが、実際に動くCLIツールの例をもって教えてくれるので、頭にスッと入ってきます。

余談ですが、こういう時にGoの美しいインターフェイスの設計を思い知らされます。

## パッケージを適切に分ける

なんでもかんでもmainパッケージに突っ込む、というのは避け、外部から利用できるような形でパッケージを分けます。  
そうすることで、ローカルで使っていたものをWeb APIのモデルとしても再利用させるといったことができます。

自分自身がユーザーだとしても、責務の境界線を敷いたりといったことに役に立つはずです。

## Repositoryパターンを使う

Repositoryパターンにより、データソースを簡単に切り替えられるようにします。

操作系を、インタフェースのメソッドとして定義し、実際の操作はインメモリやSQLのものとして実装させるのです。これにより、テストもしやすくなります。

これもずいぶんと既知の方法ですが、繰り返しになるものの、実際に動くCLIツールで示してくれるので、とても解りやすいです。

## 統合テストは実APIなりを叩く方法もある

結合テストをどう書くか、というところはけっこうな悩みどころだと思います。  
モックを使うと実際のAPIに追従できなかったりという問題が起こる可能性がありますし、実際のAPIを叩くと実環境に影響がでる可能性があります。

そこで、この本では、build constraintsを使い、統合テストファイルにtagを付与した上で、通常のテストでは実行されないようにし、-tagsオプションを使って散発的に実行するようにしています。

統合テストは通ったのに、実際には動かないといったことを避けるためのバランスの取れた方法で、なるほどなーと思いました。

自前で用意するAPIの場合、テスト用の環境を用意してあげたりすると良さそうですね。

## Cobraの使い方

[kubernetes/kubectl](https://github.com/kubernetes/kubectl)や[gh](https://github.com/cli/cli)でも使われている、メジャーなCLI用ライブラリである[spf13/cobra](https://github.com/spf13/cobra)の使い方も教えてくれます。

コマンドのmarkdownページを出力してくれる、doc.GenMarkdownTreeといった便利関数は知りませんでした。 Versionというプロパティも地味に知らずにいました。

ちなみに、Cobraの作者であるSteve Francia aka spf13さんがこの本の前書きを書いています。そのことからも、この本の品質は保証されていると言って良いのではないでしょうか？

## まとめ

他にも、main関数から適切に関数を分離してテストしやすくすることや、Golden filesによるテストの仕方や、関数の型を作っての処理の分岐のさせ方や、httptestパッケージの使い方や、ダッシュボードを作るための[Termdash](https://github.com/mum4k/termdash)ライブラリの使い方など、とにかくお役立ち情報満載の本でした。

GoでのCLIツール作りをもっと上手くなりたいという方は手にとってみてはいかがでしょうか。

[Powerful Command-Line Applications in Go: Build Fast and Maintainable Tools](https://pragprog.com/titles/rggo/powerful-command-line-applications-in-go/)
