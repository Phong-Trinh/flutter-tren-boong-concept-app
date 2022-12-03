import '../../domain/entity/order_entity.dart';
import '../remote_source/momo_payment_service.dart';
import '../remote_source/receipt_detail_service.dart';
import '../remote_source/receipt_service.dart';

class OrderRepository {
  Future<void> createReceipt(OrderEntity order) async {
    // List<int?> listId = await Future.wait(order.orderDetails
    //     .map((detail) => ReceiptDetailService.createReceiptDetail(detail)));
    // if (listId.contains(null)) {
    //   throw Exception('Create receipt detail exception');
    // }
    try {
      // int? orderId = await ReceiptService.createReceipt(
      //     order.totalPrice, listId.cast<int>(), int.parse(order.userId));
      // if (orderId == null) {
      //   throw Exception('Create order exception');
      // }
      bool checkPayment =
          await MomoPaymentService.createTransaction('1', order.totalPrice);
      if (checkPayment == false) {
        throw Exception('Create order exception');
      }
    } catch (e) {
      throw Exception('Create order exception');
    }
  }
}
