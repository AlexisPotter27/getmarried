import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/models/chat_message.dart';
import 'package:getmarried/data/models/conversation.dart';
import 'package:getmarried/models/user.dart';

abstract class ChatRepository {
  Future<ApiResponse> startConversation(ChatUser user1,ChatUser user2,String message);
  Future<ApiResponse> getUsers();
  Future<ApiResponse> sendMessage( {required String conversationId,required ChatMessage message});
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations();
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({String conversationId});
}
