import 'package:flutter/material.dart';

import '../../../helper/constant/strings.dart';
import '../../../helper/constant/styles.dart';
import '../../../helper/responsive.dart';
import '../../../models/order_model.dart';
import '../../../widgets/custom_outlined_button.dart';

class OrderItemCardWidget extends StatelessWidget {
  const OrderItemCardWidget(
      {super.key,
      required this.orderData,
      required this.cancelCallback,
      required this.viewDetailsCallback});

  final OrderData orderData;
  final VoidCallback cancelCallback;
  final VoidCallback viewDetailsCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: wp(2, context), vertical: hp(1.5, context)),
        child: SizedBox(
          width: wp(100, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "# ${orderData.id}",
                    style: textBodyStyle.copyWith(color: Colors.purple),
                  ),
                  const Spacer(),
                  Text(
                    "Table No ${orderData.tableNo.toString()}",
                    style: textSmallRegularStyle.copyWith(color: Colors.amber),
                  )
                ],
              ),
              Text(
                "time",
                // formatDateTime(DateTime.parse(orderData.createdAt!)),
                style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold),
              ),
              SizedBox(height: hp(1.5, context)),
              Row(
                children: [
                  Text(
                    "${orderData.cartItems?.length} items",
                    style: textSmallRegularStyle,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${orderData.totalPrice}",
                        style: textSmallRegularStyle.copyWith(
                            fontFamily: fontSemiBold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: hp(0.4, context),
              ),
              orderData.cartItems?.length == 0
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        Flexible(
                          child: Text(
                            formatCartItems(orderData.cartItems),
                            style:
                                smallRegularStyle.copyWith(color: Colors.grey),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: hp(1, context),
              ),
              const Divider(),
              Row(
                children: [
                  CustomOutlinedButton(
                      onPressed: viewDetailsCallback,
                      child: Row(
                        children: [
                          Text(
                            "View details",
                            style: textSmallRegularStyle,
                          ),
                          const Icon(Icons.arrow_right_outlined)
                        ],
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: cancelCallback,
                    child: Text(
                      "Cancel?",
                      style:
                          textSmallRegularStyle.copyWith(color: Colors.purple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatCartItems(List<CartItems>? cartItems) {
    if (cartItems == null || cartItems.isEmpty) {
      return ''; // Return an empty string if the cartItems list is null or empty
    }

    // Create a list of formatted strings for each item
    List<String> itemStrings =
        cartItems.map((item) => '${item.itemName} x${item.quantity}').toList();

    // Join the list of formatted strings using commas
    return itemStrings.join(', ');
  }
}
