class Note {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;
  final String userId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map, String docId) {
    return Note(
      id: docId,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
      userId: map['userId'] ?? '',
    );
  }
}
