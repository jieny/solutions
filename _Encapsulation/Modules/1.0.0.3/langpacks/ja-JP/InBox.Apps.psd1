﻿ConvertFrom-StringData -StringData @'
	# Translator                    = Yi

	AdvAppsDetailed                 = レポートを生成します
	AdvAppsDetailedTips             = 地域タグで検索し、利用可能なローカル言語エクスペリエンス パッケージを検出した後、詳細情報を取得し、レポート ファイルを生成します：CSV。
	ProcessSources                  = ソースを処理します
	InboxAppsManager                = 受信箱アプリ
	InboxAppsMatchDel               = 一致ルールによる削除
	InboxAppsOfflineDel             = プロビジョニングされたアプリケーションを削除する
	InboxAppsClear                  = インストールされているすべてのプリアプリ ( UWP) を強制的に削除します
	InstallUWP                      = UWP アプリと一致する
	InstallUWPCheck                 = 依存関係を確認する
	InstallUWPCheckTips             = ルールに従って、選択されたすべてのインストール項目を取得し、依存するインストール項目が選択されているかどうかを検証します。
	LocalExperiencePackTips         = ローカル言語エクスペリエンスパック ( LXPs )
	LEPBrandNew                     = 新しい方法で、お勧め
	UWPAutoMissingPacker            = すべてのディスクから不足しているパッケージを自動的に検索します
	UWPAutoMissingPackerSupport     = x64 アーキテクチャでは、不足しているパッケージをインストールする必要があります。
	UWPAutoMissingPackerNotSupport  = 非 x64 アーキテクチャ。x64 アーキテクチャがサポートされている場合にのみ使用されます。
	UWPEdition                      = Windows のバージョンは一意の識別子です
	UWPOptimize                     = 同一のファイルをハードリンクに置き換えることにより、Appx パッケージのプロビジョニングを最適化します
	RemoveAllUWPTips                = 命令:\n\nステップ 1: マイクロソフトが公式にリリースした対応するパッケージに対応するローカル言語エクスペリエンス パック (LXPs) を追加し、こちらに移動してダウンロードします。\n       Windows 10 マルチセッション イメージに言語パックを追加します\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/language-packs\n\n       Windows 11 エンタープライズ イメージに言語を追加します\n       https://learn.microsoft.com/en-us/azure/virtual-desktop/windows-11-language-packs\n\nステップ 2: *_InboxApps.isoを解凍またはマウントし、スキーマに基づいてディレクトリを選択します。\n\nステップ 3: マイクロソフトが最新のローカル言語エクスペリエンス パック (LXPs) をまだリリースしていない場合は、この手順をスキップします。 存在する場合: マイクロソフトが公式に発表したセキュリティ情報を参照してください。\n       1、ローカル言語体験パッケージ(LXPs)に対応します。\n       2、累積的な更新に対応します。 nnプレインストールされたアプリケーション ( UWP ) は単一言語であり、多言語を取得するには再インストールが必要です。 \n\n1、あなたは開発者バージョン、初期バージョンを選択することができます。\n    バージョン番号などの開発者バージョン:\n    Windows 11 シリーズ\n    Windows 11 23H2, Build 22631.1\n    Windows 11 22H2, Build 22621.1\n    Windows 11 21H2, Build 22000.1\n\n    初期バージョン、既知の初期バージョン:\n    Windows 11 シリーズ\n    Windows 11 23H2, Build 22631.2428\n    Windows 11 22H2, Build 22621.382\n    Windows 11 21H2, Build 22000.194\n\n    Windows 10 シリーズ\n    Windows 10 21H2, 2109, Build 19045.2006\n    Windows 10 21H2, 2109, Build 19044.1288\n    Windows 10 21H1, 2104, Build 19043.928\n    Windows 10 20H2, 2009, Build 19042.264\n    Windows 10 20H1, 2004, Build 19041.264\n    Windows 10 19H1, 1909, Build 18363.418\n\n    重要:\n      a. 21H1 から 22H2 まで、各バージョンが更新されるときは、イメージを再作成し、古いイメージに基づいて更新しないでください。 もう一度、初期バージョンを使用して作成してください。\n      b. この規制は、一部の OEM で、さまざまな形式でパッケージング担当者に明確に伝達されており、反復版から直接アップグレードすることはできません。\n      キーワード: イテレーション、クロスバージョン、累積的な更新。\n\n2、言語パックをインストールした後、累積的な更新プログラムを追加していないので、累積的な更新プログラムを追加する前に、コンポーネントに変更はありません、累積的な更新プログラムを直接インストールした後、コンポーネントの状態などの新しい変更が発生します:古い、削除する必要があります。\n\n3、累積的な更新プログラムを持つバージョンを使用して、最終的に再び累積的な更新プログラムを追加する必要があり、操作を繰り返しました。\n\n4、作成時に累積的な更新プログラムなしでバージョンを作成し、最後のステップで累積的な更新プログラムを追加することをお勧めします。 \n\nカタログを選択した後の検索条件: LanguageExperiencePack.*.Neutral.appx
	ImportCleanDuplicate            = 重複ファイルをクリーンアップする
	ForceRemovaAllUWP               = ローカル言語エクスペリエンスパック ( LXPs) の追加をスキップして他のことを行う
	LEPSkipAddEnglish               = インストール時に米国内での追加をスキップすることをお勧めします
	LEPSkipAddEnglishTips           = デフォルトの英語パックは、それを追加するのに不要です。	
	License                         = 証明書付き
	NoLicense                       = 証明書なし
	StepOne                         = ステップ 1：マーキング、ローカル言語エクスペリエンスパック ( LXPs )
	StepTwo                         = ステップ 2：
	CurrentIsNVeriosn               = N エディションシリーズ
	CurrentNoIsNVersion             = 完全に機能するバージョン
	LXPsWaitAddUpdate               = アップグレード待ち
	LXPsWaitAdd                     = 追加する
	LXPsWaitRemove                  = 削除する
	LXPsAddDelTipsView              = 新しいヒントがあります。今すぐチェックしてください
	LXPsAddDelTipsGlobal            = プロンプトはもう必要ありません。グローバルに同期してください
	LXPsAddDelTips                  = 二度と思い出させないでください
'@