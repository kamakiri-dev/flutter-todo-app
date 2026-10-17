// 複数の画面で共通して使うサイズ（余白・角丸・アイコン）
// 1 か所でしか使わない値は、使う側のファイルに名前付きの定数で置く
class AppSizes {
  // 余白（4 の倍数で刻む）
  static const double spaceXs = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 12.0;
  static const double spaceL = 16.0;
  static const double spaceXl = 24.0;
  static const double spaceXxl = 32.0;

  // 角丸
  static const double radiusM = 14.0; // カード・入力欄・ボタン
  static const double radiusL = 16.0; // 進捗サマリー
  static const double radiusXl = 20.0; // ダイアログ

  // ダイアログ上部のアイコン
  static const double dialogIcon = 32.0;
}
