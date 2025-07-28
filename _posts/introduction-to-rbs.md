---
title: Rubyで型を扱うためのRBSの概要とRailsプロジェクトへの痛みのない導入方法
date: '2023-12-08T08:48:00+09:00'
draft: false
---

### この記事の概要

これは[SmartHR Advent Calendar 2023](https://qiita.com/advent-calendar/2023/smarthr)シリーズ 1の8日目の記事です。

この記事では、Rubyで型を扱うための基盤である[RBS](https://github.com/ruby/rbs)について、いくつかのリソースを参照しながら、説明および、既存のRuby on Railsプロジェクトに恩恵だけに預かる形での導入方法を紹介します。

sinsokuさんの[Railsアプリと型検査](https://speakerdeck.com/sinsoku/rails-app-and-type-checking)というスライドを見て、そんな形で型定義の導入ができるのか、となったことがきっかけで試してみたことです。ありがとうございます。

### RBSとは

RBSを含めたRubyの静的解析機能周りについては[Ruby 3の静的解析機能のRBS、TypeProf、Steep、Sorbetの関係についてのノート - クックパッド開発者ブログ](https://techlife.cookpad.com/entry/2020/12/09/120454)に短くまとまっています。  
これによると、RBSはその言語を主体とした4種類からなる「型を扱うための基盤」と言えるようです。

また、RBS単体については、RBSのコミッターである[Pocke](https://me.pocke.me/)さんが[RubyWorld Conference 2023](https://2023.rubyworld-conf.org/ja/)で講演した[RBS Tutorial](https://www.youtube.com/watch?v=TKg2UzNwdgw&t=21077s)に15分でよくまとまっています。

かいつまんでまとめると、以下のような感じです:

- RBSのファイル（.rbs）はRubyのファイル（.rb）からは完全に分離されている
    - TypeScriptの.jsと.d.tsと似た感じ
- Rubyと構文が違う
    - [Sorbet](https://github.com/sorbet/sorbet)はRubyのコードで型を書くのでそこは違う
- RBSの環境は.rbsファイルしか参照しない
- 構文はこちら: https://github.com/ruby/rbs/blob/master/docs/syntax.md

この講演では後半でRBSの小さな始め方についても触れられているので、興味のある方はぜひ動画を観てみてください。

### 実際に既存のRuby on Railsプロジェクトに導入する

RBSが何なのかぼんやり分かったところで、さっそく既存のRuby on Railsプロジェクトに導入してみましょう。

ここではRBSに対応した静的型検査ツールである[Steep](https://github.com/soutaro/steep)を利用して、Visual Studio Codeでの主に補完機能の強化を行うことを目標にします。  
Steepは型違反のチェック機能なども持っていますが、ここでは無視します。また、自作コードに型定義を追加することはせず、既存のgem周りの型の定義だけ取得することにします。これらは対応するのにそれなりの工数がかかるであろうためです。

冒頭で挙げた[sinsokuさんのスライド](https://speakerdeck.com/sinsoku/rails-app-and-type-checking)と、そちらで紹介されていた[Railsプロジェクトへの「頑張らない型導入」のすすめ - メドピア開発者ブログ](https://tech.medpeer.co.jp/entry/2023-small-rbs-introduce)を存分に参考にします。

#### Steepをセットアップ

まずはSteepをセットアップします。

Steepはこのようなものです（引用）:

> Steep は、Ruby の静的型検査器です。RBS を使って、伝統的な漸進的型付けによる型検査を行うことができます。 単に型エラーを検出できるだけではなく、LSP を実装しているので、エディタ上での型エラー表示、補完、ドキュメント表示なども実装されています。

[Ruby 3の静的解析機能のRBS、TypeProf、Steep、Sorbetの関係についてのノート - クックパッド開発者ブログ](https://techlife.cookpad.com/entry/2020/12/09/120454) より。

Gemfileに以下のように `:development` グループに追記します:

```ruby
group :development do
  gem "steep", require: false
end
```

`bundle install` を実行します。  
`bundle exec steep init` を実行します。  
`Steepfile` がプロジェクトトップディレクトリに出来るので、以下のように書き換えます:

```ruby
D = Steep::Diagnostic

target :app do
  signature "sig"
  check "app"

  configure_code_diagnostics(D::Ruby.silent)
end
```

`configure_code_diagnostics(D::Ruby.silent)` が重要で、型のエラーチェックをしないようにします。何もしない状態だと既存のコードに対してエラーが溢れるので、それを防止します。
本当はエラーチェックもできると良いのですが（型はそのためにあるとも言えそうです）、今回は痛みなくという方針なので頑張らずに無視します。

#### rbs_rails gemをセットアップ

[rbs_rails](https://github.com/pocke/rbs_rails)とはRuby on Rails用のRBSファイルジェネレーターです。

Gemfileに以下のように `:development` グループに追記します:

```ruby
group :development do
  gem 'rbs_rails', require: false
end
```

`bundle install` を実行します。  
`bin/rails g rbs_rails:install` を実行します。`lib/tasks/rbs.rake` が作成されます。  
いったんここまでにしておきます。

#### rbs collectionのセットアップ

[rbs collection](https://github.com/ruby/rbs/blob/master/docs/collection.md)はサードパーティgemのRBSを生成してくれる便利なツールです。

上記リポジトリのドキュメントには

> In short, it is bundler for RBS.

と書かれていますね。

`bundle exec rbs collection init` を実行します。  
`rbs_collection.yaml` が作成されます。これは書き換えずにこのまま利用します。

#### rbs.rakeの調整

`bin/rails g rbs_rails:install` で作られた `rbs.rake` をこのように書き換えます:

```ruby
return unless Rails.env.development?

require "rbs_rails/rake_task"

namespace :rbs do
  task setup: %i(clean collection rbs_rails:all)

  task clean: :environment do
    sh "rm", "-rf", "sig/rbs_rails"
    sh "rm", "-rf", ".gem_rbs_collection"
  end

  task collection: :environment do
    sh "rbs", "collection", "install"
  end

  task validate: :environment do
    sh "rbs", "-Isig", "validate", "--silent"
  end
end

RbsRails::RakeTask.new do |task|
  # If you want to avoid generating RBS for some classes, comment in it.
  # default: nil
  #
  # task.ignore_model_if = -> (klass) { klass == MyClass }

  # If you want to change the rake task namespace, comment in it.
  # default: :rbs_rails
  # task.name = :cool_rbs_rails

  # If you want to change where RBS Rails writes RBSs into, comment in it.
  # default: Rails.root / 'sig/rbs_rails'
  # task.signature_root_dir = Rails.root / 'my_sig/rbs_rails'
end
```

これでRBSファイル生成の準備ができました！

#### RBSファイルの生成

さて、ここまででセットアップが終わったので、いよいよRBSファイルの生成を行います。  
その前に、`.gitignore` に無視対象になるRBSファイルなどを追加しておきます。  
RBSファイルやrbs collectionのロックファイルの差分がメンバー間で出てしまうことを防ぐと同時に、型情報なんて必要ないという人は生成セットアップをせずに済む優しい作りにしておきます。

これらを `.gitignore` に追加します:

```text
.gem_rbs_collection
rbs_collection.lock.yaml
/sig
```

準備が整いました！RBSファイルの生成を行いましょう。

用意したRakeコマンドを実行するだけです:  
`bundle exec rake rbs:setup`

`.gem_rbs_collection` 配下と `sig` 配下にRBSファイルが生成されたはずです。

これで痛みのないRBSの導入は完了です。
手で書いたコードは0に近いですが、果たしてこれだけで型情報の恩恵にあずかれるのでしょうか。

Visual Studio Codeの設定をしてみましょう。

#### Visual Studio Codeの設定

[公式Steep拡張](https://marketplace.visualstudio.com/items?itemName=soutaro.steep-vscode)をインストールしてSteepの機能を有効にしましょう。  
プロジェクトを開いていた場合は有効化後にもう一度開き直すと良いようです。

さてどうなっているでしょうか。

この拡張を有効化する前は `Date` で `.current` が補完できてなかったのが…  
![Date.current補完ビフォー](/images/blog/introduction-to-rbs/date_current_before.png)

できるようになった！  
![Date.current補完アフター](/images/blog/introduction-to-rbs/date_current_after.png)

さらにクラスにカーソルを当てるとこういうドキュメントも出るようになった！  
![Dateクラスのドキュメントのポップアップ](/images/blog/introduction-to-rbs/date_class_document.png)

これだけでもRBSを導入した甲斐があるというものではないでしょうか。

ちなみにSteep拡張の利用の際は、以下が必須なので気をつけましょう（特に1行目）:

> You have to have Steepfile in the root of the folder.  
> You have to use Bundler.

これでRuby on RailsプロジェクトへのRBSの傷みのない導入はひとまず完了です。

### あとがき

RBSの概要の紹介と実際のRuby on Railsプロジェクトへの導入について書いてみました。

ここから自分で型を定義してガチガチに固めるとなると、それはそれで違った痛みが生まれるのではないかと想像していますが、試してみる価値もありそうです。  
また、Visual Studio Code以外のエディターで恩恵に預かれるかまでは調べられなかったので、知っている方がいたら教えていただきたいです。

Rubyの世界で今後の型との付き合い方がどうなっていくのか、楽しみです。
