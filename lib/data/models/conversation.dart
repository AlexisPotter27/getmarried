// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

import 'package:getmarried/data/models/chat_message.dart';

Conversation conversationFromJson(String str) =>
    Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  Conversation({
    required this.id,
    required this.user1,
    required this.user2,
    required this.lastMessage,
    required this.createdAt,
    required this.users

  });

  String id;
  ChatUser user1;
  ChatUser user2;
  ChatMessage lastMessage;
  DateTime createdAt;
  List<String> users;


      Conversation copyWith({
    String? id,
    ChatUser? user1,
    ChatUser? user2,
    ChatMessage? lastMessage,
    DateTime? createdAt,
    List<String>? users,

  }) =>
      Conversation(
        id: id ?? this.id,
        user1: user1 ?? this.user1,
        user2: user2 ?? this.user2,
        lastMessage: lastMessage ?? this.lastMessage,
        createdAt: createdAt ?? this.createdAt,
        users: users ?? this.users,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      Conversation(
        id: json["id"],
        user1: ChatUser.fromJson(json["user1"]),
        user2: ChatUser.fromJson(json["user2"]),
        lastMessage: ChatMessage.fromJson(json["last_message"]),
        users: List<String>.from(json["users"].map((x) => x)),
        createdAt: DateTime.fromMicrosecondsSinceEpoch(json["created_at"]),

      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "user1": user1.toJson(),
        "user2": user2.toJson(),
        "last_message": lastMessage.toJson(),
        "created_at": createdAt.millisecondsSinceEpoch,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}

class ChatUser {
  ChatUser({
    required this.id,
    required this.name,
    required this.photos,
    required this.about,
  });

  String id;
  String name;
  List<dynamic> photos;
  String about;

  ChatUser copyWith({
    String? id,
    String? name,
    List<dynamic>? photos,
    String? about,
  }) =>
      ChatUser(
        id: id ?? this.id,
        name: name ?? this.name,
        photos: photos ?? this.photos,
        about: about ?? this.about,
      );

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      ChatUser(
        id: json["id"],
        name: json["name"],
        photos: List<dynamic>.from(json["photos"].map((x) => x)),
        about: json["about"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "about": about,
      };
}
