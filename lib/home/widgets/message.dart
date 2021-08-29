class Message {
  final String topic;
  final String content;

  Message({required this.topic, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(topic: json['title'], content: json['content']);

  Map<String, dynamic> toJson() => {'title': topic, 'content': content};
}
