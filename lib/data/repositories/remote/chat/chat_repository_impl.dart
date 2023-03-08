import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/data/repositories/remote/chat/chat_repository.dart';
import 'package:getmarried/models/user.dart';

class ChatRepositoryImpl extends ChatRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<ApiResponse> startConversation(user1, user2, message) async {
    try {
      DocumentReference conversations =
      db.collection(FirebaseKeys.conversation).doc();
      DocumentReference messageReference =
      conversations.collection('messages').doc();

      final chatMessage = ChatMessage(
          id: messageReference.id,
          senderId: user2.id!,
          text: message,
          timeSent: DateTime.now());
      final conversation = Conversation(
          id: conversations.id,
          lastMessage: chatMessage,
          user1: user1,
          user2: user2,
          createdAt: DateTime.now());
      await conversations.set(conversation.toJson());
      await messageReference.set(chatMessage.toJson());
      return ApiResponse(data: conversation, error: null);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }

    // throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations() {
    return db.collection(FirebaseKeys.conversation).snapshots();
  }

  @override
  Future<ApiResponse> getUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await db.collection(FirebaseKeys.users).get();
      List<UserData> users =
      snapshot.docs.map((e) => UserData.fromJson(e.data())).toList();
      return ApiResponse(data: users, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {String? conversationId, String? userId}) {

    // if (conversationId == null) {
    //   return db
    //       .collection(FirebaseKeys.conversation)
    //       .where('user1', whereIn: true).snapshots()
    // }

    return db
        .collection(FirebaseKeys.conversation)
        .doc(conversationId)
        .collection('messages').orderBy('timeSent',descending: false)
        .snapshots();
  }

  @override
  Future<ApiResponse> sendMessage(
      {required String conversationId, required ChatMessage message}) async {
    try {
      DocumentReference conversationReference = db.collection(FirebaseKeys.conversation).doc(conversationId);
      DocumentReference reference = db.collection(FirebaseKeys.conversation).doc(conversationId).collection('messages').doc();
      await reference.set(message.copyWith(id: reference.id).toJson());
      await conversationReference.update(message.copyWith(id: reference.id).toJson());

      return ApiResponse(data: message.copyWith(id: reference.id), error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: {}, error: e.toString());
    }
  }
}
