import 'dart:ffi';
import 'order.dart'; // Import the Order model

class OrderHistory {
  String? date;
  List<Order>? orders;

  OrderHistory({this.date, this.orders});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
