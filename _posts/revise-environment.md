---
title: Vimを始めとして環境を見直してみた
date: '2021-09-18T16:01:00+09:00'
draft: false
---

僕は開発環境にはJetBrains IDEsを使って、その他のテキスト編集にはVimを使ったりVisual Studio Codeを使ったりといったことをやっているのだけど、ふと使う道具を少なくしようとVisual Studio Codeは使わずに、がっつりした開発以外のテキスト編集やスクリプト作成などにはVimを使おうと思い立った。高機能なVisual Studio Codeを単なるテキストエディターとしか使えておらず、Vimはカスタマイズや操作を組み立てるのが楽しかったり、ターミナルから抜け出さなくて良いというのが理由。

それでまずは6年前に読んだ実践Vim（の英語改訂版）を読み返した。プラグインの機能はほとんど使用せずに様々な操作が可能なことを教えてくれるこの本はVim wayを知る上で本当にいい本だと思う。新たな学びもあったけど、ふとした時に出てくる自信のない操作も多い（マクロとか）。

あとはVimを使った開発の動画を観たりした。良かったのはこの2本: [tmuxとvimによる開発作業フロー (動画) \| 週休７日で働きたい](https://blog.craftz.dog/my-dev-workflow-using-tmux-vim-48f73cc4f39e)、 [【解説】開発ライブ実況 #1 (Vim / Go) 編 by メルペイ Architect チーム Backend エンジニア #mercari_codecast \| メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/mercari_codecast_1/)。特にメルカリの方のやつは作業が速すぎてRTSのプロゲーマーを観ているようだった。

んでそのままの勢いに実践Vimと同じ著者が書いたVim 8とNeovimについての[Modern Vim](https://pragprog.com/titles/modvim/modern-vim/)を買って読んだ。といっても "Craft Your Development Environment" と副題がついているように、開発環境向けの機能やプラグインの紹介が多く、僕の利用目的とは合わない感じだったのでそういうプラグインもあるんだな、Neovimにはそういう機能があるのねー、程度にざっと読んだ。

動画を観た影響もあり、Vimで開発もやってしまったらかっこいいなーと思いつつ、カスタマイズや操作の修練も行き過ぎるとけっこうダルいなと思ってしまったし、JetBrainsのAll Products Packにお金を納めたばかりだったので一本化はやめることにした。

そして出来上がったVimの環境なのだけど、とりあえずNeovimにcoc.nvimを入れてLSPによる恩恵に預かることにはしたのだけど、コンフィグやプラグインはかなりミニマルな構成にした。昔入れたプラグインやキーバインドも使ってないものはごっそり捨てた（dotfilesは[こちら](https://github.com/tommy6073/dotfiles/)）。

あとはtmuxについて[tmux 2](https://pragprog.com/titles/bhtmux2/tmux-2/)を読み返したけどそんなに発見が無くて十分使いこなせてる感を感じたあと、[Tao of tmux](https://leanpub.com/the-tao-of-tmux/read)をざっと読んだり、fzfを使った便利なコマンド無いかなーと探したり（結局使いたいと思うものは増えなかった）といったことをやっていた。

とりあえずVimの環境はスタートラインに立てたので、あとは必要に応じてカスタマイズしたり習熟していきたいと思う。というこの記事をNeovimで書いたのであった。
