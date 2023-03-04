abstract class LocalStore{
  Future<void> init();

  Future<void> set<T>(String key, T value);

  Future<dynamic> get(String key);

  Future<void> delete(String key);

  Future<void> clearAll();
}