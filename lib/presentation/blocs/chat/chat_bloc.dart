import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/models/user.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StreamSubscription? conversationSubscription;
  StreamSubscription? messagesSubscription;
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetConversationEvent>(_mapGetConversationEventsToState);
    on<GetUsersEvent>(_mapGetUsersEventToState);
    on<StartConversationEvent>(_mapStartConversationEventToState);
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<ConversationFetchedEvent>(_mapConversationFetchedEventToState);
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
    on<GetMessageWithIdEvent>(_mapGetMessagesWithIdEvent);
    on<MessagesFetchedEvent>(_mapMessageFetchedEventToState);
  }

  FutureOr<void> _mapGetConversationEventsToState(
      GetConversationEvent event, Emitter<ChatState> emit) async {
    // emit();
    log('loading');

    try {
      conversationSubscription?.cancel();
      conversationSubscription = chatRepository
          .getUserConversations(event.userId)
          .asBroadcastStream()
          .listen((event) {
        if (event != null) {
          add(ConversationFetchedEvent(
              event.docs.map((e) => Conversation.fromJson(e.data())).toList()));
          log(event.docs[0].data().toString());
        }
      });
    } on FirebaseException catch (e) {
      log('failed${e.code}');

      // emit(UsersErrorState(e.code));
    } catch (e, stack) {
      log('failed${stack.toString()}');

      // emit(UsersErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapGetUsersEventToState(
      GetUsersEvent event, Emitter<ChatState> emit) async {
    emit(UsersLoadingState());

    try {
      ApiResponse response = await chatRepository.getUsers();
      if (response.error == null) {
        emit(UsersFetchedState(response.data));
      } else {
        emit(UsersErrorState(response.error.toString()));
      }
    } on FirebaseException catch (e) {
      emit(UsersErrorState(e.code));
    } catch (e) {
      emit(UsersErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapStartConversationEventToState(
      StartConversationEvent event, Emitter<ChatState> emit) async {
    emit(StartConvoLoadingState());
    log('loading');
    try {
      ApiResponse response = await chatRepository.startConversation(
          event.user1, event.user2, event.message);
      if (response.error == null) {
        log('sucesss');
        emit(StartConvoSuccesState((response.data as Conversation)));
        add(GetMessagesEvent(
            conversationId: (response.data as Conversation).id));
        // emit(UsersFetchedState(response.data));
      } else {
        // emit(UsersErrorState(response.error.toString()));
      }
    } on FirebaseException catch (e) {
      log('failed${e.code}');

      emit(StartConvoErrorState(e.code));
      // emit(UsersErrorState(e.code));
    } catch (e, stack) {
      log('failed${stack.toString()}');

      emit(StartConvoErrorState(e.toString()));

      // emit(UsersErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapConversationFetchedEventToState(
      ConversationFetchedEvent event, Emitter<ChatState> emit) async {
    log(event.conversations.length.toString());
    emit(ConversationFetchedState(event.conversations));
  }

  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    emit(MessagesLoadingState());
    log('loading');

    try {
      messagesSubscription?.cancel();
      messagesSubscription = await chatRepository
          .getMessages(conversationId: event.conversationId!)
          .asBroadcastStream()
          .listen((event) {
        log('fetched${event.docs.length}');

        add(MessagesFetchedEvent(
            messages: event.docs
                .map((e) => ChatMessage.fromJson(e.data()))
                .toList()));
      });
    } on FirebaseException catch (e) {
      log('failed${e.code}');

      emit(MessagesErrorState(e.code));
    } catch (e, stack) {
      log('failed${stack.toString()}');

      emit(MessagesErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapMessageFetchedEventToState(
      MessagesFetchedEvent event, Emitter<ChatState> emit) async {
    emit(MessagesFetchedState(event.messages));
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    // emit(UsersLoadingState());

    try {
      ApiResponse response = await chatRepository.sendMessage(
          conversationId: event.conversationId, message: event.message);
      if (response.error == null) {
        // emit(UsersFetchedState(response.data));
      } else {
        emit(UsersErrorState(response.error.toString()));
      }
    } on FirebaseException catch (e) {
      // emit(UsersErrorState(e.code));
    } catch (e) {
      // emit(UsersErrorState(e.toString()));
    }
  }

  FutureOr<void> _mapGetMessagesWithIdEvent(
      GetMessageWithIdEvent event, Emitter<ChatState> emit) async {
    emit(MessagesLoadingState());
    try {
      ApiResponse<List<Conversation>, dynamic> response = await chatRepository
          .getMessageWithId(user1: event.user1, user2: event.user2);
      if (response.error == null) {
        if (response.data!.isNotEmpty) {
          add(GetMessagesEvent(conversationId: response.data?.first.id));
        } else {
          emit(MessagesFetchedState(const []));
        }
      }
    } on FirebaseException catch (e) {
      // emit(UsersErrorState(e.code));
    } catch (e) {
      // emit(UsersErrorState(e.toString()));
    }
  }
}
