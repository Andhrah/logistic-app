abstract class IRepository {
  add<T>({required T item, required String key, required String name});
  // addAll<T>();
  T get<T>({required String key, required String name});
  remove<T>({required String key, required String name});
  clear<T>({required String name});
}
