part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class GetConversationEvent extends ChatEvent {
  String userId;

  GetConversationEvent(this.userId);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetUsersEvent extends ChatEvent {
  GetUsersEvent();

  @override
  List<Object?> get props => [];
}

class ConversationFetchedEvent extends ChatEvent {
  final List<Conversation> conversations;

  ConversationFetchedEvent(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class StartConversationEvent extends ChatEvent {
  final ChatUser user1;
  final ChatUser user2;
  final String message;

  @override
  List<Object?> get props => [];

  StartConversationEvent(this.user1, this.user2, this.message);
}

class SendMessageEvent extends ChatEvent {
  final ChatMessage message;
  final String conversationId;

  @override
  List<Object?> get props => [message, conversationId];

  SendMessageEvent({required this.message, required this.conversationId});
}

class GetMessagesEvent extends ChatEvent {
  final String? conversationId;

  @override
  List<Object?> get props => [conversationId];

  GetMessagesEvent({this.conversationId});
}

class MessagesFetchedEvent extends ChatEvent {
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [messages];

  MessagesFetchedEvent({required this.messages});
}

class GetMessageWithIdEvent extends ChatEvent {
  String user1;
  String user2;

  GetMessageWithIdEvent({required this.user1, required this.user2});

  @override
  List<Object?> get props => [user1, user2];
}
