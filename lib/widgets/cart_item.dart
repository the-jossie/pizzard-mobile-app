import 'package:flutter/material.dart';
import 'package:pizzard/models/cart.dart';
import 'package:provider/provider.dart';

class CartPdt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String name;

  CartPdt({this.id, this.productId, this.price, this.quantity, this.name});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Image(),
            ),
          ),
          title: Text(
            name,
          ),
          subtitle: Text(
            'Total: \$${price * quantity}',
          ),
          trailing: Text(
            '$quantity x',
          ),
        ),
      ),
    );
  }
}