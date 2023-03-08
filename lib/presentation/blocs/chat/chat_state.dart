part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ConversationFetchedState extends ChatState {
  final List<Conversation> conversations;

  ConversationFetchedState(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class ConversationLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class ConversationErrorState extends ChatState {
  @override
  List<Object?> get props => [];
}

class UsersFetchedState extends ChatState {
  List<UserData> users;

  UsersFetchedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class UsersErrorState extends ChatState {
  String error;

  UsersErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class MessagesFetchedState extends ChatState {
  List<ChatMessage> chatMessages;

  MessagesFetchedState(this.chatMessages);

  @override
  List<Object?> get props => [chatMessages];
}

class MessagesLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class MessagesErrorState extends ChatState {
  String error;

  MessagesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class SendMessagesSuccesState extends ChatState {
  // SendMessagesSuccesState();

  @override
  List<Object?> get props => [];
}

class SendMessagesLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class SendMessagesErrorState extends ChatState {
  String error;

  SendMessagesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class StartConvoSuccesState extends ChatState {
  Conversation conversation;

  StartConvoSuccesState(this.conversation); // SendMessagesSuccesState();

  @override
  List<Object?> get props => [conversation];
}

class StartConvoLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class StartConvoErrorState extends ChatState {
  String error;

  StartConvoErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
