// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'dart:convert';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  ChatMessage(
      {required this.id,
      required this.senderId,
      required this.text,
      required this.timeSent});

  String id;
  String senderId;
  String text;
  DateTime timeSent;

  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? text,
  }) =>
      ChatMessage(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        text: text ?? this.text,
        timeSent: this.timeSent,
      );

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        senderId: json["senderId"],
        text: json["text"],
        timeSent: DateTime.fromMicrosecondsSinceEpoch(json['timeSent']*1000),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderId": senderId,
        "text": text,
        "timeSent": timeSent.millisecondsSinceEpoch
      };
}
