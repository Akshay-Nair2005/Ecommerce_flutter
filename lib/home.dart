import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/pages/cart_page.dart';

Future<List<dynamic>> getProducts() async {
  var res = await http.get(Uri.https("fakestoreapi.com", "products"));
  return json.decode(res.body);
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> products = [];
  List<dynamic> cartItems = [];

  @override
  void initState() {
    super.initState();
    getProducts().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  void showAddedToCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Akshay'sOwn"),
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItems: cartItems),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            child: ListTile(
              title: Text(
                products[index]['title'],
                style: const TextStyle(color: Colors.white),
              ),
              leading: Image.network(
                products[index]['image'],
                width: 80,
                height: 80,
              ),
              trailing: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[400]),
                ),
                onPressed: () {
                  setState(() {
                    cartItems.add(products[index]);
                  });
                  showAddedToCartDialog();
                },
                child: const Icon(
                  Icons.add,
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
