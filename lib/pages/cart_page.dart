import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<dynamic> cartItems;

  const CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        title: const Text('Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
              'Your cart is empty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      )),
                  child: ListTile(
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Image.network(
                      item['image'],
                      width: 80,
                      height: 80,
                    ),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[400]),
                      ),
                      onPressed: () => removeFromCart(index),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
