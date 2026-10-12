# todo_app

Flutter 製のシンプルな Todo アプリです。Todo の作成・編集・削除・完了の切り替えができ、データは端末内の SQLite に保存されます。UI は日本語です。

## 機能

- **一覧表示**: Todo をカードで一覧表示します。上部に「のこり◯件」「◯ / ◯ 完了」の進捗を表示します
- **新規作成**: 右下の ＋ ボタンから、タイトル（必須）・期限・メモを入力して保存します
- **編集**: カードをタップすると編集画面が開きます
- **完了の切り替え**: カードのチェックボックスで完了 / 未完了を切り替えます
- **削除**: カードを長押しすると、確認ダイアログを出してから削除します
- **空表示・エラー表示**: Todo が 0 件のときは案内を、読み込みに失敗したときは再読み込みボタンを表示します
- **永続化**: SQLite（`sqflite`）に保存するため、アプリを閉じてもデータが残ります

## 使用技術

| 用途 | パッケージ |
|---|---|
| 状態管理 | `flutter_bloc`（Bloc パターン） |
| ルーティング | `go_router` |
| 永続化 | `sqflite` / `sqflite_common_ffi_web`（Web 版） |
| 日本語化 | `flutter_localizations`（ロケール `ja_JP`） |
| Lint | `flutter_lints` |

## セットアップ

```bash
flutter pub get
flutter run
```

### Web 版で動かす場合

Web 版の SQLite に必要なファイル（`web/sqflite_sw.js`, `web/sqlite3.wasm`）はリポジトリに含めていません。初回に次のコマンドで生成してください。

```bash
dart run sqflite_common_ffi_web:setup
flutter run -d chrome
```

## よく使うコマンド

```bash
flutter analyze          # 静的解析
dart format lib test     # フォーマット
flutter test             # テスト
```

## ディレクトリ構成

```text
lib/
├── main.dart                         // エントリポイント。依存の組み立てと BlocProvider / MaterialApp.router
├── app/
│   ├── router/app_router.dart        // ルーティング（'/' 一覧, '/edit' 作成・編集）
│   └── theme/
│       ├── app_colors.dart           // 色定義
│       └── app_theme.dart            // テーマ
├── common/
│   ├── constants/app_texts.dart      // UI 文言
│   ├── formatter/date_formatter.dart // 日付表示（yyyy年M月d日）
│   └── validator/todo_validator.dart // 入力チェック
└── features/
    └── todo/
        ├── bloc/                     // TodoBloc / TodoEvent / TodoState
        ├── data/
        │   ├── todo_database.dart          // DB 生成・テーブル定義
        │   ├── todo_local_data_source.dart // CRUD の SQL 操作
        │   └── todo_mapper.dart            // TodoItem <-> Map 変換
        ├── model/todo_item.dart      // TodoItem（イミュータブル）
        ├── repository/todo_repository.dart // Bloc と DataSource の仲介
        └── view/
            ├── todo_home_page.dart   // 一覧画面
            ├── todo_edit_page.dart   // 作成・編集画面
            └── widget/               // カード、空表示、進捗ヘッダー、削除ダイアログ
```

## アーキテクチャ

```text
View ──add(Event)──> TodoBloc ──> TodoRepository ──> TodoLocalDataSource ──> SQLite
  ^                     │
  └── BlocBuilder <── emit(State)
```

- 画面からは `TodoBloc` にイベント（`TodoLoad` / `TodoSaved` / `TodoDeleted` / `TodoToggled`）を送るだけで、DB には直接触りません
- `TodoBloc` は操作のあとに一覧を取り直し、`TodoSuccess` / `TodoFailure` などの State を流します
- `TodoItem.id == 0` を新規として扱い、保存時に insert / update を切り替えます
- 依存は `main.dart` でコンストラクタ注入して組み立てています

## DB

- DB 名 `todo.db`、テーブル `todos`
- カラム: `id`（AUTOINCREMENT）, `title`, `memo`, `date`（ISO8601 文字列）, `is_completed`（0/1）
