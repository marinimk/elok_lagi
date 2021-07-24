class Order {
  final String oid;
  final String cuid;
  final String ruid;
  final String message;
  final String pickUpTime;
  final String ordertime;
  final double totalPrice;

  Order(
      {this.oid,
      this.cuid,
      this.ruid,
      this.message,
      this.pickUpTime,
      this.ordertime,
      this.totalPrice});
}
