abstract class AuthRepository {
  Future sendSms(String number, String resendToken);
}
