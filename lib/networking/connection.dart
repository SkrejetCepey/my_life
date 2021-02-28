class Connection {

  Connection();

  Future connect() async {
    await Future.delayed(Duration(seconds: 5));
  }

}