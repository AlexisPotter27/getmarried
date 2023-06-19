// import 'package:getmarried/helper/http_helper.dart';
//
// class PaymentRepository {
//   final HttpHelper httpClient;
//
//   PaymentRepository(this.httpClient);
//
//
//
//   Future<State> fetchActiveSubscription() async {
//     return SimplifyApiConsuming.makeRequest(
//           () => httpClient.post(Endpoints.activeSubscription),
//       successResponse: (data) {
//         return State<SubscriptionResponse?>.success(
//             SubscriptionResponse.fromMap(data));
//       },
//       statusCodeSuccess: 200,
//       errorResponse: (response) {
//         debugPrint('ERROR SERVER');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data.toString(),
//               data: null),
//         );
//       },
//       dioErrorResponse: (response) {
//         debugPrint('DIO SERVER FROM FETCH SUBSCRIPTION');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data['message'],
//               data: null),
//         );
//       },
//     );
//   }
//
//   Future<State> fetchPaymentHistory() async {
//     return SimplifyApiConsuming.makeRequest(
//           () => httpClient.post(Endpoints.paymentHistory),
//       successResponse: (data) {
//         return State<PaymentHistoryResponse?>.success(
//             PaymentHistoryResponse.fromMap(data));
//       },
//       statusCodeSuccess: 200,
//       errorResponse: (response) {
//         debugPrint('ERROR SERVER');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data.toString(),
//               data: null),
//         );
//       },
//       dioErrorResponse: (response) {
//         debugPrint('DIO SERVER');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data['message'],
//               data: null),
//         );
//       },
//     );
//   }
//
//   Future<State> startFreeTrial() async {
//     return SimplifyApiConsuming.makeRequest(
//           () => httpClient.post(Endpoints.startFreeTrial),
//       successResponse: (data) {
//         return State<String?>.success("Free trial activation successful");
//       },
//       statusCodeSuccess: 200,
//       errorResponse: (response) {
//         debugPrint('ERROR SERVER');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data.toString(),
//               data: null),
//         );
//       },
//       dioErrorResponse: (response) {
//         debugPrint('DIO SERVER');
//         return State<ServerErrorModel>.error(
//           ServerErrorModel(
//               statusCode: response.statusCode!,
//               errorMessage: response.data['message'],
//               data: null),
//         );
//       },
//     );
//   }
// }