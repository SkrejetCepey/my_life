
abstract class Database<T> {

  Future<void> create(T createEntry);

  Future<void> update(T updateEntry);

  Future<List<T>> getAll();

  Future<void> delete(T desire);

}