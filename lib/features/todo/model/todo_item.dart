class TodoItem {
  final int id;
  final String title;
  final String memo;
  final DateTime date;
  final bool isCompleted;

  const TodoItem({
    required this.id,
    required this.title,
    this.memo = "",
    required this.date,
    this.isCompleted = false,
  });

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
