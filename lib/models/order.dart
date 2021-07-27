class Order {
  final String oid;
  final String cuid;
  final String ruid;
  final String message;
  final String date;
  final String pickUpTime;
  final String orderTime;
  final double totalPrice;
  final bool ready;
  final bool completed;

  Order({
    this.oid,
    this.cuid,
    this.ruid,
    this.message,
    this.date,
    this.pickUpTime,
    this.orderTime,
    this.totalPrice,  
    this.ready,
    this.completed,
  });
}
