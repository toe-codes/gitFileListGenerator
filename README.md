# gitFileListGenerator

## 概要

gitのリビジョン間における変更ファイル一覧をcsvファイルとして出力するシェルスクリプトです。

## 必要な動作環境

- gitがインストールされていること
- Rがインストールされていること

  - dplyrライブラリがインストールされていること

- bashが使えること

## 使い方

以下のコマンドを実行します。

```
$ ./gitFileListGenerator.sh [リポジトリのルートディレクトリ] [修正前リビジョンのハッシュ] [修正後のリビジョンのハッシュ]
```

- **[リポジトリのルートディレクトリ]** : 「.git」ファイルがあるディレクトリを指定します。
- **[修正前リビジョンのハッシュ]** : 修正前リビジョンのハッシュを指定します。リビジョンのハッシュは「git log」コマンドなどで調べることができます。
- **[修正後のリビジョンのハッシュ]** : 修正後のリビジョンのハッシュを指定します。ハッシュの代わりに「master」を指定することができます。

## デモ

[apache/commons-lang: Mirror of Apache Commons Lang](https://github.com/apache/commons-lang)のファイル一覧を例に詳しい使い方を説明します。

以下のコマンドを入力します。

```
$ ./path/to/gitFileListGenerator.sh path/to/commons-lang 20de433aa24957e40d974b87aba54ae0688500ed master
```

コマンドが正常に実行されると、以下のcsvファイルが出力されます。

`path/to/result/result.csv`

```
"","path","status","insertion","deletion"
"1","pom.xml","Modify",2,2
"2","src/site/resources/release-notes/RELEASE-NOTES-1.0.1.txt","Modify",16,1
"3","src/site/resources/release-notes/RELEASE-NOTES-1.0.txt","Modify",16,1
"4","src/site/resources/release-notes/RELEASE-NOTES-2.0.txt","Modify",16,1
"5","src/site/resources/release-notes/RELEASE-NOTES-2.1.txt","Modify",16,1
"6","src/site/resources/release-notes/RELEASE-NOTES-2.2.txt","Modify",16,1
"7","src/site/resources/release-notes/RELEASE-NOTES-2.3.txt","Modify",16,1
"8","src/site/resources/release-notes/RELEASE-NOTES-2.4.txt","Modify",16,1
"9","src/site/resources/release-notes/RELEASE-NOTES-2.5.txt","Modify",16,1
"10","src/site/resources/release-notes/RELEASE-NOTES-2.6.txt","Modify",16,1
"11","src/site/resources/release-notes/RELEASE-NOTES-3.0.1.txt","Modify",16,1
"12","src/site/resources/release-notes/RELEASE-NOTES-3.0.txt","Modify",16,1
"13","src/site/resources/release-notes/RELEASE-NOTES-3.1.txt","Modify",16,1
"14","src/site/resources/release-notes/RELEASE-NOTES-3.2.1.txt","Modify",1,2
"15","src/site/resources/release-notes/RELEASE-NOTES-3.2.txt","Modify",1,2
```

`result.csv`はリビジョン間で変更のあったファイル一覧です。

`path/to/result/resultAll.csv`

```
"","path","status","insertion","deletion"
"1",".gitattributes","","",""
"2",".gitignore","","",""
"3",".travis.yml","","",""
"4","CONTRIBUTING.md","","",""
"5","LICENSE.txt","","",""
"6","NOTICE.txt","","",""
"7","README.md","","",""
"8","RELEASE-NOTES.txt","","",""
"9","checkstyle-suppressions.xml","","",""
"10","checkstyle.xml","","",""
"11","findbugs-exclude-filter.xml","","",""
"12","pom.xml","Modify","2","2"
"13","src/assembly/bin.xml","","",""
"14","src/assembly/src.xml","","",""
"15","src/changes/changes.xml","","",""
...
...
...
```

`resultAll.csv`はリポジトリの全ファイル一覧に`result.csv`の内容を加えたものです。

- **path** : ファイルパスを示します。
- **status** : ファイルのステータスを示します。各ステータスの意味は以下の通りです。

  - Modify: 修正
  - Add: 追加
  - Copy: コピー
  - Rename: リネーム
  - Delete: 削除

- **insertion** : リビジョン間で追加された行数です。

- **deletion** : リビジョン間で削除された行数です。
