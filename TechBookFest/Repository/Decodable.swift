//
//  Decodable.swift
//  TechBookFest
//
//  Created by 長田卓馬 on 2019/10/22.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

struct GitHubRepository: Decodable {
    let id: Int
    let fullName: String
    let description: String
    let stargazersCount: Int
    let url: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case url = "html_url"
    }

}

struct SearchRepositoriesResponse: Decodable {
    let items: [GitHubRepository]
}

struct CircleResponse: Decodable {
    let circles: [Circle]
    
    private enum CodingKeys: String, CodingKey {
        case circles = "result"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.circles = try container.decode([Circle].self, forKey: .circles)
    }
}

struct Circle: Decodable, Hashable {
    
    let id: Int
    let circleURL: String
    let circle: String
    let circleImage: String
    let arr: String
    let genere: String
    let keyword: String
    let title: String
    let content: String
    
    func contains(_ filter: String) -> Bool {
        guard !filter.isEmpty else {
            return true
        }

        let lowercasedFilter = filter.lowercased()
        return circle.lowercased().contains(lowercasedFilter)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case circleURL = "CircleURL"
        case circle = "Circle"
        case circleImage = "CircleImage"
        case arr
        case genere = "Genere"
        case keyword = "Keyword"
        case title = "Title"
        case content = "Content"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.circleURL = try container.decode(String.self, forKey: .circleURL)
        self.circle = try container.decode(String.self, forKey: .circle)
        self.circleImage = try container.decode(String.self, forKey: .circleImage)
        self.arr = try container.decode(String.self, forKey: .arr)
        self.genere = try container.decode(String.self, forKey: .genere)
        self.keyword = try container.decode(String.self, forKey: .keyword)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
    }
}

let json = """
{
    "result": [
        {
            "id": 23,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5639817928900608\n",
            "Circle": "EZ-NET（イージーネット）",
            "CircleImage": "https://lh3.googleusercontent.com/UR_lhbQq0LE_TtOlraM89b8Uz9EU5htj5ZLEIMbymKm5ZImW6cWGvaX5EEiSCjarzzFmiqUbq0TVa0ljd4gf9w",
            "arr": "あ01C",
            "Genere": "ソフトウェア全般",
            "Keyword": "プログラミング、とりわけ勉強会の楽しさを伝えたい、そんな気持ちを発端に始まった技術同人誌のシリーズ。今回は Swift 入門書として『Swift らしい表現を目指そう』と『Swift イニシャライザー大全』を頒布します。どちらとも表側から Swift を眺める本になっているので 雑学 というより言語を扱うときの 素養 として活用できる本、楽しくコードを書くために欠かせない 言語 としての入門書として仕立てています。そして今回は新刊として Swift の 変数 についての解説書と、海外のロー",
            "Title": "Swift 変数入門 ー お試し版",
            "Content": "Swift を変数定義という観点から見渡す入門書を制作していましたが、間に合わなかったので第4章までのお試し版を無料頒布することにしました。\n\n変数の性質や、その性質を想定した型定義の仕組みなど、広い視野で Swift 言語を眺めるニャァ文書に仕上げるべく鋭意執筆中です。"
        },
        {
            "id": 24,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5639817928900608\n",
            "Circle": "EZ-NET（イージーネット）",
            "CircleImage": "https://lh3.googleusercontent.com/UR_lhbQq0LE_TtOlraM89b8Uz9EU5htj5ZLEIMbymKm5ZImW6cWGvaX5EEiSCjarzzFmiqUbq0TVa0ljd4gf9w",
            "arr": "あ01C",
            "Genere": "ソフトウェア全般",
            "Keyword": "プログラミング、とりわけ勉強会の楽しさを伝えたい、そんな気持ちを発端に始まった技術同人誌のシリーズ。今回は Swift 入門書として『Swift らしい表現を目指そう』と『Swift イニシャライザー大全』を頒布します。どちらとも表側から Swift を眺める本になっているので 雑学 というより言語を扱うときの 素養 として活用できる本、楽しくコードを書くために欠かせない 言語 としての入門書として仕立てています。そして今回は新刊として Swift の 変数 についての解説書と、海外のロー",
            "Title": "Swift イニシャライザー大全 ",
            "Content": "今どきのオブジェクト指向的なプログラミングでは欠かせないイニシャライザー。型からインスタンスを生成するときに使う初期化関数みたいなものですけれど、その特徴を理解するのは単純そうで思ったよりも複雑です。オブジェクト指向の継承関係だけでも案外複雑なのに、Swift 言語では構造体もイニシャライザーを持つようになり、プロトコル指向とも相まって、その関係を把握するのがさらに複雑になりました。そこで今回は、そんな Swift 言語におけるイニシャライザーの基本的なところを整理してみます。\n\n\n目次\n\n　第1章 : イニシャライザーの基本\n　第2章 : 構造体のイニシャライザー\n　第3章 : クラス型のイニシャライザー\n　第4章 : 列挙型のイニシャライザー\n　第5章 : 複合型のイニシャライザー\n　第6章 : 初期化できない場合を考慮する\n　第7章 : 変換イニシャライザー\n　第8章 : リテラル変換\n　第9章 : プロトコルでのイニシャライザー\n　第10章 : 型拡張で定義する"
        },
        {
            "id": 25,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5639817928900608\n",
            "Circle": "EZ-NET（イージーネット）",
            "CircleImage": "https://lh3.googleusercontent.com/UR_lhbQq0LE_TtOlraM89b8Uz9EU5htj5ZLEIMbymKm5ZImW6cWGvaX5EEiSCjarzzFmiqUbq0TVa0ljd4gf9w",
            "arr": "あ01C",
            "Genere": "ソフトウェア全般",
            "Keyword": "プログラミング、とりわけ勉強会の楽しさを伝えたい、そんな気持ちを発端に始まった技術同人誌のシリーズ。今回は Swift 入門書として『Swift らしい表現を目指そう』と『Swift イニシャライザー大全』を頒布します。どちらとも表側から Swift を眺める本になっているので 雑学 というより言語を扱うときの 素養 として活用できる本、楽しくコードを書くために欠かせない 言語 としての入門書として仕立てています。そして今回は新刊として Swift の 変数 についての解説書と、海外のロー",
            "Title": "Swift らしい表現を目指そう",
            "Content": "Swiftらしいコードってなんだろう。Swift言語に注目が集まり、多くの人が Swiftらしさを求めてコードを描き彷徨いました。唯一の手がかりであるSwift標準ライブラリーの定義を、ただただ懸命に観察しながら。それから時は経ち、Apple自身もSwift 3の登場と合わせて Swift APIデザインガイドライン を公開して、指針を示してくれました。いよいよ機は熟した感じ。せっかくだから一緒にSwiftらしさを目指してみましょう。\n\n\n目次\n\n　第1章 : Swift らしい表現を目指そう\n　第2章 : 関数名とメソッド名\n　第3章 : イニシャライザー名\n　第4章 : 機能の所属\n　第5章 : 型キャスト\n　第6章 : 比較可能な型\n　第7章 : テキスト表現可能な型\n　第8章 : 連続的な値を受け取る"
        },
        {
            "id": 30,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5175169173684224\n",
            "Circle": "渋谷アプリラボ（シブヤアプリラボ）",
            "CircleImage": "https://lh3.googleusercontent.com/AbWk-DQUQDGFQGR8vwVY2emtJ4kRfba9W3ag3DCSL0Anm51obdeh4men_fdtd31mPA3ftuCm2GGg6Mp97Vnn0Q",
            "arr": "あ04C",
            "Genere": "ソフトウェア全般",
            "Keyword": "SwiftUIの入門本",
            "Title": "入門SwiftUI",
            "Content": "SwiftUIについて簡単なサンプルアプリケーションと共に解説します。"
        },
        {
            "id": 31,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[書籍版]SwiftUI実践入門",
            "Content": "【紙の書籍での配布となります】\nWWDC19でSwiftUIが発表されました。アプリ開発を高品質かつ素早く開発できる革新的なUIフレームワークです。\n本書はSwiftUIを理解し使いこなすために必要なもの、すべてを網羅した一冊です。SwiftUIのコンセプトから実際のレイアウト方法、Swift5.1の新機能、Xcodeのプレビュー機能、データモデルの状態管理などなど、これ一冊でSwiftUIの概要と実際の開発を理解することができます。\nぜひ本書とともにSwiftUIの新しい世界に飛び込みましょう！"
        },
        {
            "id": 32,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[PDF版]SwiftUI実践入門",
            "Content": "【PDFでの配布となります】\nWWDC19でSwiftUIが発表されました。アプリ開発を高品質かつ素早く開発できる革新的なUIフレームワークです。\n本書はSwiftUIを理解し使いこなすために必要なもの、すべてを網羅した一冊です。SwiftUIのコンセプトから実際のレイアウト方法、Swift5.1の新機能、Xcodeのプレビュー機能、データモデルの状態管理などなど、これ一冊でSwiftUIの概要と実際の開発を理解することができます。\nぜひ本書とともにSwiftUIの新しい世界に飛び込みましょう！"
        },
        {
            "id": 33,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[セット版]SwiftUI実践入門",
            "Content": "【紙の書籍とPDFのセットの配布となります】\nWWDC19でSwiftUIが発表されました。アプリ開発を高品質かつ素早く開発できる革新的なUIフレームワークです。\n本書はSwiftUIを理解し使いこなすために必要なもの、すべてを網羅した一冊です。SwiftUIのコンセプトから実際のレイアウト方法、Swift5.1の新機能、Xcodeのプレビュー機能、データモデルの状態管理などなど、これ一冊でSwiftUIの概要と実際の開発を理解することができます。\nぜひ本書とともにSwiftUIの新しい世界に飛び込みましょう！"
        },
        {
            "id": 34,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[書籍版]Swift Package Manager 入門",
            "Content": "【紙の書籍の配布となります】\nこの本は、Swift Package Manager(SwiftPM)の基本的な使い方を紹介した本です。 WWDC 2019 で Xcode 11 への SwiftPM の統合が発表され、さらに OSS コミュニティ が活発になると筆者は期待しています。この本を手にとった方が、改めて SwiftPM に興 味を持ち、OSS コミュニティに関わるきっかけになればとても嬉しく思います。"
        },
        {
            "id": 35,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[PDF版]Swift Package Manager 入門",
            "Content": "【PDFの配布となります】\nこの本は、Swift Package Manager(SwiftPM)の基本的な使い方を紹介した本です。 WWDC 2019 で Xcode 11 への SwiftPM の統合が発表され、さらに OSS コミュニティ が活発になると筆者は期待しています。この本を手にとった方が、改めて SwiftPM に興 味を持ち、OSS コミュニティに関わるきっかけになればとても嬉しく思います。"
        },
        {
            "id": 36,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5184699437678592\n",
            "Circle": "Personal Factory（パーソナルファクトリー）",
            "CircleImage": "https://lh3.googleusercontent.com/kX_Tp2XwDZYz2LmzXMCkUdYGIoV4VAgJJREBJwai0bSrDjhCYBzR_F541_EMNdeZVF1GwYPO1G7KMq5BBl4",
            "arr": "あ05C",
            "Genere": "ソフトウェア全般",
            "Keyword": "「SwiftUI実践入門」WWDC19にて発表された新しいユーザーインターフェイスSwiftUIを徹底的に解説する本です。「SwiftPM入門」Swift Package Managerについて解説します。「ハーフモーダルで理解するFluid Interface」Appleが提唱する直感的に使えるユーザーインターフェイスの極意を地図アプリなどでよくみるハーフモーダルで解説しました。",
            "Title": "[セット版]Swift Package Manager 入門",
            "Content": "【紙の書籍とPDFの配布となります】\nこの本は、Swift Package Manager(SwiftPM)の基本的な使い方を紹介した本です。 WWDC 2019 で Xcode 11 への SwiftPM の統合が発表され、さらに OSS コミュニティ が活発になると筆者は期待しています。この本を手にとった方が、改めて SwiftPM に興 味を持ち、OSS コミュニティに関わるきっかけになればとても嬉しく思います。"
        },
        {
            "id": 42,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5693125439782912\n",
            "Circle": "うさぎてっく（ウサギテック）",
            "CircleImage": "https://lh3.googleusercontent.com/KLY2YjUtP5BTaV6cxoMft2VDQtyfamRWX8oFai1zarsPs4r6fQNXRdgDfoJZDYXSCQCI3omf_E0zDc3SmQ3iIQ",
            "arr": "あ06C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS, Swiftに関するTips本, SwiftUIのサンプル集",
            "Title": "SwiftUI Catalog",
            "Content": "2019年のWWDCで発表されたSwiftUIのサンプルを集めたカタログ本です。\n基本コンポーネントの見本と、よく見るアプリのUIをSwiftUIで再現してみたサンプルを収録しています。\n\n本書を通じて、SwiftUIでどのようにUIを作成するのかを知っていただければと思います。\n※UI作成に特化しているため、データバインディングは考慮していません"
        },
        {
            "id": 44,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/4877362839683072\n",
            "Circle": "エンジニア登山部（エンジニアトザンブ）",
            "CircleImage": "https://lh3.googleusercontent.com/dcCgEnWWa-iYnFgUJFDcN4zd6hW0m_PATt8GR1OmEg0EtxW-sFJ0NGgW7nFQbSP7uYnuTcWjTjgtsPaDqM5b",
            "arr": "あ08C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS,ログ分析,DDD",
            "Title": "これからの「分析」の話をしよう",
            "Content": "最先端かつ地力を養うのに最適な１冊！\n「SwiftUI」は革新的で非常にシンプルなUI構築の手段を提供する、Appleによる最新のUI構築フレームワークです。\nそして、アプリグロースの最大化に辿り着くには必須である「分析」。\n本書ではSwiftUIと分析の二大テーマを掲げて書き上げたものです。\n\nあなたはログ分析のことまで考えて設計できますか？\nアプリケーションの実装から運用時のログ分析に至るまで、\n実際に体験することでわかってくる、\nよりよりアプリケーションの開発とは？"
        },
        {
            "id": 46,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/4877362839683072\n",
            "Circle": "エンジニア登山部（エンジニアトザンブ）",
            "CircleImage": "https://lh3.googleusercontent.com/dcCgEnWWa-iYnFgUJFDcN4zd6hW0m_PATt8GR1OmEg0EtxW-sFJ0NGgW7nFQbSP7uYnuTcWjTjgtsPaDqM5b",
            "arr": "あ08C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS,ログ分析,DDD",
            "Title": "これからの「分析」の話をしよう（紙+電子書籍セット）",
            "Content": "最先端かつ地力を養うのに最適な１冊！\n「SwiftUI」は革新的で非常にシンプルなUI構築の手段を提供する、Appleによる最新のUI構築フレームワークです。\nそして、アプリグロースの最大化に辿り着くには必須である「分析」。\n本書ではSwiftUIと分析の二大テーマを掲げて書き上げたものです。\n\nあなたはログ分析のことまで考えて設計できますか？\nアプリケーションの実装から運用時のログ分析に至るまで、\n実際に体験することでわかってくる、\nよりよりアプリケーションの開発とは？\n\nこちらは書籍と電子版のセット販売用です。"
        },
        {
            "id": 48,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5633595997683712\n",
            "Circle": "Flydea（フライディア）",
            "CircleImage": "https://lh3.googleusercontent.com/lE1eEMX7H7StzabKkw_kzsp54wmGKmkx0wao6btqQWlbR4NFRhlsJgRMlKHaEtYb8WamyCH3Dhe5vfVSYi8",
            "arr": "あ09C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOSアプリ開発に関わる方向けのフレームワーク関連の技術書・UI / UX関連の書籍を予定しています",
            "Title": "iPhoneで使える触覚フィードバックの教科書",
            "Content": "この本はAppleの一部の製品に搭載されているTaptic Engineを使った触覚フィードバックに関する技術書です。\niPhoneを使っている人なら経験がある、バイブレーションとは違うぶるっと震える振動、それがTaptic Engineを使用した触覚フィードバックです。\n\n本書ではその触覚フィードバックを使ったUX向上・改善を目的とした本です。\n\nSwiftのプログラムコードも書かれているので、この本を読めばすぐに導入することができます。\nまた、iOSアプリ開発者だけでなく、プログラムの知識がないサービスのUXデザイナーの方もお読みいただける本に仕上げる予定です。\n\n主に以下の内容となる予定です。\n\n第1章：Taptic Engineとは\n第2章：Taptic Engineによる触覚フィードバックの実装\n第3章：既存アプリケーションのTaptic Engineの導入例\n第4章：触覚フィードバックの効果的な導入パターンとアンチパターン\n第5章：iOS 13から使える新時代の触覚フィードバック\n\n本書を読めば、\n\n・Taptic Engineや触覚フィードバックについて詳しくなれます\n・携わっているアプリケーションのグロース、改善に一役立てます\n・Taptic Engineって何ができるの？の答えがここにあります\n\n本書があれば、触覚フィードバックの基礎から応用までが誰でもわかるようになります。"
        },
        {
            "id": 51,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5686484359184384\n",
            "Circle": "shu223（シューツーツーミー）",
            "CircleImage": "https://lh3.googleusercontent.com/if2Togyz7PNtsLCBT2TFpqWUqdJmHFpESGxWUwUE149xm7DV8cJguAn3zNqLcWzwPxfGAQ9IX0WP6mFDtkpo",
            "arr": "あ10C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS 13の新機能解説書＋iOS×Depthの解説書＋ARKitの解説書＋Metalの解説書＋macOSの解説書",
            "Title": "iOS 13の新機能をざっくり把握する本 製本版＋電子版セット",
            "Content": "本書はiOS 13で新規追加されたAPIについて、筆者が実際にコードを書いて試しつつ書いた本です。新機能について「何が」「どういう実装で」実現できるのかを解説しています。さらっと読めるので新機能をざっくり把握したい方におすすめです。\n\nSwift UIやSign In with Appleのような多くの方が話題にしている内容は入っていませんが、その他の新機能も知っておいて損はないものばかりです。本書はまだあまり情報が出ていない機能を中心に紹介しているので、Swift UI等の本命新機能は公式チュートリアル等でがっつり学びつつ、その他新機能を本書でサッとキャッチアップされてはいかがでしょうか。\n"
        },
        {
            "id": 53,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5686484359184384\n",
            "Circle": "shu223（シューツーツーミー）",
            "CircleImage": "https://lh3.googleusercontent.com/if2Togyz7PNtsLCBT2TFpqWUqdJmHFpESGxWUwUE149xm7DV8cJguAn3zNqLcWzwPxfGAQ9IX0WP6mFDtkpo",
            "arr": "あ10C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS 13の新機能解説書＋iOS×Depthの解説書＋ARKitの解説書＋Metalの解説書＋macOSの解説書",
            "Title": "iOSエンジニアのためのmacOSアプリ開発入門 製本版+電子版セット",
            "Content": "macOSアプリ開発は、「使用言語はSwift」「IDEはXcode」「標準フレームワークの多くがiOSと共通」と、iOSアプリ開発と共通点が多いため、iOSエンジニアにとっては比較的とっつきやすいはずです。・・・が、「UIKitではなくAppKitだし、なんだかんだと色んな点で違っていてめんどくさそう」という気がして**興味はあるけど未だ手付かず**という方も多いのではないでしょうか。\n\nそこで本書では、iOSエンジニアの視点から「これ、macOSではどうやるの？」という事項を集めてまとめてみました。各項の解説は「iOSエンジニアに伝われば十分」という観点で非常に簡潔に書いてあるので、本書をパラパラと眺めてみるだけでも「違いといってもこんなもんか。簡単そうだからやってみよう。」という気分になるはずです。本書が最初の一歩の後押しになると幸いです。"
        },
        {
            "id": 60,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5758041588760576\n",
            "Circle": "Falcon Tech（ファルコンテック）",
            "CircleImage": "https://lh3.googleusercontent.com/UiDrAy3GUOOAo_iPOP-OIBUDzCAbfU8PLMlR8DR26s8wKNv8tHxxhHQ89DcEMn_qhsUU3S_fGVflFLeoJVD6",
            "arr": "あ14C",
            "Genere": "ソフトウェア全般",
            "Keyword": "XcodeでiOS, watchOS, tvOS などのアプリで利用するライブラリ開発技術について",
            "Title": "Embedded Framework（電子書籍のみ）",
            "Content": "本書はSwiftで作るアプリケーションを細かなモジュール単位に分けて開発する術である Embedded Frameworkについて解説した書籍です。\n 以下の内容について取り上げています。\n  - Frameworkとは何か \n - Embedded Frameworkの固有のメリット\n - Embedded Frameworkを取り入れたアプリ開発とは "
        },
        {
            "id": 61,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5632928868466688\n",
            "Circle": "xr203（エックスアールニマルサン）",
            "CircleImage": "https://lh3.googleusercontent.com/doi7NToBIAlZRGp-ObBVQu-Z3HAdnRdcFc8IgpvakXh7vMcrLfgx7Z1cPWgP8fIkGRlSa1avGvA9loMYKAQ",
            "arr": "あ15C",
            "Genere": "ソフトウェア全般",
            "Keyword": "SwiftUI",
            "Title": "きょうからまなぶ　しょうがっこう　すうぃふとゆーあい",
            "Content": "プログラム初心者を対象にした、SwiftUIの基本を学ぶ本です。SwiftUIの基礎からわかりやすく説明し、最終的には簡単なメモアプリを作成して理解を深める仕様です。ぜひ遊びにきてください!"
        },
        {
            "id": 64,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5634582229549056\n",
            "Circle": "AbemaTV（アベマティービー）",
            "CircleImage": "https://lh3.googleusercontent.com/_v3RVwCzFJ859e5mtopOC54EANL5JwVi-T3bbAbtA_not2tceCWDeHqkS0696t8TyK37FvHW_Zk6fzHLKkhU8A",
            "arr": "あ18C",
            "Genere": "ソフトウェア全般",
            "Keyword": "新刊はiOS、Android、Web、サーバー、配信、デザインと、様々な方面の知見をまとめた１冊となる予定です！ぜひお買い求めください！",
            "Title": "AbemaTV Tech Book",
            "Content": "国内最大級の無料インターネットテレビ局AbemaTVの様々な分野のメンバーによる初の技術同人誌！\niOS、Android、Web、サーバー、配信、デザインと、様々な方面の知見をまとめた270Pにおよぶ超大作です！\nぜひお買い求めください！\n\n[目次]\n1. JavaScript AST から目覚めるぼくらのリファクタリング / 宮代 理弘\n2. AbemaTV で学ぶ RxJS / 野口 直寛\n3. Electronで簡単なMacアプリをシュッと作る / 竹田 智\n4. HTML5 Canvasを使って映像の上にオーバーレイするシステムを作ってみた / 山中 勇成（みゆっき）\n5. AbemaTV競輪チャンネルにおけるレース予想解説ARアプリをiPhone1台で実現する / 辰己 佳祐\n6. AVPlayerでiOSの動画プレイヤーを自作する / 竹田 光佑\n7. SwiftSyntaxBuilder = SwiftSyntax × Function Builders / 安井 瑛男\n8. Groupieとパフォーマンス / 外山 椋\n9. AndroidアプリケーションにおけるZeroconfによるNetwork Service Discovery / 國師 誠也\n10. HashiCorp Vault 入門 / 辻 純平\n11. Design doc って？ なぜ書くの？ なにを書くの？ どう書くの？ / 久保田 翔太\n12. A/Bテストに対するデザインの向き合い方 / 松本 俊介\n13. 動画品質制御の高度化の実現プロセス / 御池 崇史\n\n\n「AbemaTV」について\n\n「AbemaTV」は、無料で楽しめるインターネットテレビ局として展開する、新たな動画配信事業。2016年4月に本開局し、オリジナルの生放送コンテンツや、ニュース、音楽、スポーツ、ドラマなど多彩な番組が楽しめる約20チャンネルを全て無料で提供し、利用者を伸ばしています。登録は不要で、スマートフォンやPC、タブレットなど様々な端末でテレビを観るような感覚で利用することができるほか、「Amazon Fire TVファミリー」や「AndroidTV」など主要なテレビデバイスにも対応しています。\n\n公式サイト：https://abema.tv"
        },
        {
            "id": 65,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5634582229549056\n",
            "Circle": "AbemaTV（アベマティービー）",
            "CircleImage": "https://lh3.googleusercontent.com/_v3RVwCzFJ859e5mtopOC54EANL5JwVi-T3bbAbtA_not2tceCWDeHqkS0696t8TyK37FvHW_Zk6fzHLKkhU8A",
            "arr": "あ18C",
            "Genere": "ソフトウェア全般",
            "Keyword": "新刊はiOS、Android、Web、サーバー、配信、デザインと、様々な方面の知見をまとめた１冊となる予定です！ぜひお買い求めください！",
            "Title": "AbemaTV iOS Tech Book",
            "Content": "国内最大の無料インターネットテレビ局AbemaTVのiOS Teamによる初の技術同人誌！\n配信技術からUXへの高いこだわり、デザインパターン、パズルの自動生成まで幅広い内容の一冊です！\n\n[目次]\n1. Swiftでリアルタイム映像のクロマキー合成処理をやってみる / satoshi0212\n2. ほどよいフィードバックでワンランク上のユーザー体験を実現する / cokaholic\n3. BLoC Pattern Introduction with Swift / to4iki\n4. Swiftでナンバーリンクパズルの自動生成 / Nonchalant\n5. あとがき　ー筆者紹介ー\n\n\n「AbemaTV」について\n\n「AbemaTV」は、無料で楽しめるインターネットテレビ局として展開する、新たな動画配信事業。2016年4月に本開局し、オリジナルの生放送コンテンツや、ニュース、音楽、スポーツ、ドラマなど多彩な番組が楽しめる約20チャンネルを全て無料で提供し、利用者を伸ばしています。登録は不要で、スマートフォンやPC、タブレットなど様々な端末でテレビを観るような感覚で利用することができるほか、「Amazon Fire TVファミリー」や「AndroidTV」など主要なテレビデバイスにも対応しています。\n\n公式サイト：https://abema.tv"
        },
        {
            "id": 71,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5163613027303424\n",
            "Circle": "エムティーアイ執筆部（エムティーアイシッピツブ）",
            "CircleImage": "https://lh3.googleusercontent.com/klc2w42NPfWmf7QaSSx7ZHOwVMT9r7PuohYBGhZzk4yimGwz6X7m_C7ZBSMaV09Tztqda2aW4Lye_F984Tec",
            "arr": "い01C",
            "Genere": "ソフトウェア全般",
            "Keyword": "エムティーアイ初の出展です。記念すべき1回目はモバイルアプリ(iOS・Android)開発についての技術書を頒布します。Flutter、Kotlin、Swift、UIテスト、Firebaseなどモバイルアプリの開発全般について解説します。",
            "Title": "エムティーアイ TechBook #1",
            "Content": "エムティーアイが頒布する初めての技術書です。記念すべき#1はモバイルアプリ(iOS・Android)開発の技術に特化しています。Flutter、Kotlin、Swift、UIテスト、Firebaseなどモバイルアプリの開発全般について解説します。\n\n---\n\n第1章 既存のiOS,AndroidプロジェクトにFlutterを導入しよう\n第2章 Firebase Notification Composerを用いたプッシュ通知の運用事例\n第3章 Page ObjectパターンによるUIテスト\n第4章 Android初心者が1ヶ月学んで得た知見とつまずいたところ\n第5章 日本のサマータイムに苦しめられた話（Swiftリメイク）"
        },
        {
            "id": 104,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5749378115436544\n",
            "Circle": "feb19（フェブラリーナインティーン）",
            "CircleImage": "https://lh3.googleusercontent.com/RjokFKJS1Y6QwAUr-91pBEcliMBWzRn9xNfeBT_n2X1Qm5YtlCVq3vK7xswhNCqxOXd656FA62nMnT55wH-h",
            "arr": "い14C",
            "Genere": "ソフトウェア全般",
            "Keyword": "iOS (Swift) と Android (Kotlin) のアプリ開発のネタになるような本はいかがですか？ Apple と Google が力を入れている健康関連のテクノロジー (HealthKit / Google Fit) が面白いのでこれについての本をそれぞれと、両方に対応した実践本を頒布します。すべて会場特別価格で提供します。是非サークルをチェックリストに追加をお願いします〜！",
            "Title": "App Recipe Book 「体重管理アプリ」 モバイルアプリ DIY レシピ",
            "Content": "「体重を管理するアプリのレシピ本」です。\n\niOS / Android 両方のネイティブアプリ開発の初歩を一つの本にしました。\n\nプロジェクトを作るところからリリースするまでの流れを通して「Swift / Xcode / Apple HealthKit」「Kotlin / Android Studio / Google Fit SDK」のアプリ開発入門について学ぶことができます。\n\n  実際に App Store / Google Play でリリースした体重管理プロトタイプアプリ「Taijuu」を題材にしています。このアプリの基礎的な機能の実装コードとその解説をご覧いただけます。\n\n  主に以下の内容にフォーカスしています。\n\n * HealthKit / Google Fit との接続\n * 体重・身長・BMI (iOS のみ) の読み書きについて\n * テキストフィールド: 文字列バリデーション、文字数入力制限、入力可能文字制限\n * ピッカー UI コントロールの操作\n * グラフ、リストビュー (UIITableView / RecyclerView) の描画・表示\n * パスコード機能の開発\n * ローカル通知機能の開発\n\nPDF ダウンロード版カード付き。"
        },
        {
            "id": 145,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5727998573543424\n",
            "Circle": "Wantedly執筆部（ウォンテッドリーシッピツブ）",
            "CircleImage": "https://lh3.googleusercontent.com/MkcSErCxEQ6-A0eP4YlWY6_0TAYpNNcUbJR4r1jpPDXC39r7tJXLtXjgLxqV5TsC_l0os7hyku3zNTS5q6s",
            "arr": "い33C",
            "Genere": "ソフトウェア全般",
            "Keyword": "ウェブサービス開発に関する技術的な挑戦や日々の試行錯誤から得られた知見を紹介していきます。",
            "Title": "SwiftUI Book",
            "Content": "SwiftUI をいち早くプロダクション投入できるようにキャッチアップしている内容を社内のiOSチームで執筆しました。"
        },
        {
            "id": 191,
            "CircleURL": "https://techbookfest.org/event/tbf07/circle/5083097825542144\n",
            "Circle": "タカノ書房（タカノショボウ）",
            "CircleImage": "https://lh3.googleusercontent.com/PAOD6I6xsUpGkY-11pef8aUSt3YsQn_DlNf4_Bgsweu1XnayouipyLesNBVrOqr1Wq0gMERjdBDGfUM3sAI",
            "arr": "い49C",
            "Genere": "ソフトウェア全般",
            "Keyword": "スマートフォンアプリ向けサーバーレスサービス「ニフクラ mobile backend」チーム内の有志で構成されたサークルです。サービスリリース6周年を記念して、サービスの中の人が書く、モバイルプラットフォームの裏側に関する同人誌などを予定しています。",
            "Title": "mobile backend を語りたい～中の人たちの6周年記念号～",
            "Content": "2013年に産声をあげてから早6年。此度、国産mBaaS「ニフクラ mobile backend」のなかの人有志で、6周年記念号を刊行することといたしました。アプリプラットフォームの裏側、表側、有効的な使い方、気を付けて欲しいこと、などなど書きしたためましたのでどうぞお楽しみください。\n\n＜ピックアップ記事＞\n・ニフクラ mobile backend をSwiftUIで使ってみる\n・Unity SDK Tips集\n・1万PVからはじめるクラウドサービス\n\nその他、mobile backendを活用した結婚式の余興ゲーム、リリース当時の裏話、などなど興味深い記事がもりだくさん！\nおかげさまで30,000ユーザー60,000アプリに利用される国産最大級mBaaS「ニフクラ mobile backend」を、これからも、どうぞどうぞ宜しくお願い致します。"
        }
    ]
}
""".unescaped
