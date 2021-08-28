class Message {
  final String title;
  final String content;

  Message({required this.title, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(title: json['title'], content: json['content']);

  Map<String, dynamic> toJson() => {'title': title, 'content': content};
}
