class Connection {

  Connection();

  Future connect() async {
    await Future.delayed(Duration(seconds: 5));
    throw Exception('Connection failed!\nRequest timeout - 408');
  }

}