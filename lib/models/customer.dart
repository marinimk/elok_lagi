class Customer {
  final String username;
  final String email;
  final String password;
  final String location;
  final String phoneNum;
  final String imageURL;
  final List cart;

  Customer(
      {this.username,
      this.email,
      this.password,
      this.location,
      this.phoneNum,
      this.imageURL,
      this.cart});
}

class CustomerData {
  final String uid;
  final String username;
  final String email;
  final String password;
  final String location;
  final String phoneNum;
  final String imageURL;
  final List cart;

  CustomerData(
      {this.uid,
      this.username,
      this.email,
      this.password,
      this.location,
      this.phoneNum,
      this.imageURL,
      this.cart});
}
