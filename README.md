## 導入ライブラリ
### dependencies
- breakpoint
- provider
- go_router

### dev_dependencies
- freezed
- intl
- import_sorter

## 環境の分割
dart-defines-from-fileを利用
下記のファイルに環境ごとのキーなどをいれる
dev.json(バージョン管理外)
stg.json(バージョン管理外)
prod.json(バージョン管理外)

## Flutterのバージョン管理
fvm

## コマンドの短縮
makefile

## Androidの署名
key.propertiesを利用(バージョン管理外)
debugビルド時は共通のdebug.keystoreを利用

## Lint
analysis_options.yamlで厳しめに設定

## Github Actions
Androidの署名テクニック

ああ
