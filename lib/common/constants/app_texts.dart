class AppTexts {
  static const todoList = 'Todo一覧';
  static const todoCreate = 'Todo新規作成';
  static const todoEdit = 'Todo編集';

  static const todoTitle = 'タイトル';
  static const todoDate = '期限';
  static const todoMemo = 'メモ';

  static const titleHint = 'タイトルを入力してください';
  static const memoHint = 'メモを入力してください（任意）';

  static const todoSave = '保存';
  static const titleError = 'タイトルが入力されていません';

  static const emptyTitle = 'Todoはまだありません';
  static const emptyMessage = ' ボタンからTodoを新規作成しよう！';

  // 進捗ヘッダー
  static String remaining(int count) => count == 0 ? 'すべて完了！' : 'のこり $count 件';
  static String progress(int done, int total) => '$done / $total 完了';

  // 削除確認ダイアログ
  static const deleteConfirmTitle = 'Todoを削除しますか？';
  static String deleteConfirmMessage(String title) =>
      '「$title」を削除します。\nこの操作は取り消せません。';
  static const cancel = 'キャンセル';
  static const delete = '削除';

  // エラー
  static const errorTitle = 'エラーが発生しました';
  static const errorMessage = 'もう一度お試しください。';
  static const ok = 'OK';
}
