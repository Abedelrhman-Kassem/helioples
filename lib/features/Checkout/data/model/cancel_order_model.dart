class CancelOrderModel {
  String? msg;

  CancelOrderModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }
}
