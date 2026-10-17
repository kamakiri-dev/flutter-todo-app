class TodoItem {
  // 未保存（新規）の Todo の id。保存時に DB が採番する
  static const newId = 0;

  final int id;
  final String title;
  final String memo;
  final DateTime date;
  final bool isCompleted;

  const TodoItem({
    required this.id,
    required this.title,
    this.memo = '',
    required this.date,
    this.isCompleted = false,
  });

  bool get isNew => id == newId;

  TodoItem copyWith({
    int? id,
    String? title,
    String? memo,
    DateTime? date,
    bool? isCompleted,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
