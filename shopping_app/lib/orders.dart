import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/apiRequests/dummyJson/endpoints.dart';
import 'package:shopping_app/currencyFormat.dart';
import 'package:shopping_app/models/order.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/navigationbar.dart';
import 'package:shopping_app/products.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State {
  Future<List<Order>>? orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.blue.shade400,
      ),
      drawer: const CustomNavigationBar(),
      body: FutureBuilder(
        future: orders,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: buildOrdersList(snapshot.data),
                        ),
                      ),
                    );
                  }
                }
              }
            case ConnectionState.none:
          }
          throw "Error";
        },
      ),
    );
  }

  @override
  void initState() {
    isConnected().then((internet) {
      if (internet) {
        setState(() {
          orders = getOrdersList();
        });
      }
    });
    super.initState();
  }
}

List<Widget> buildOrdersList(List<Order> orders) {
  var widgets = <Widget>[];

  for (var order in orders) {
    widgets.add(Card(
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                DateFormat('dd-MM-yyyy').format(order.date),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text('Total: \$${currencyFormat(order.total)}')
            ],
          ),
        ),
        collapsed: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Show products'),
          ),
        ),
        expanded: Center(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            itemCount: order.products.length,
            itemBuilder: (context, index) {
              return generateColum(order.products[index]);
            },
          ),
        ),
      ),
    ));
  }

  return widgets;
}

Widget generateColum(Product product) => Card(
      child: ListTile(
        leading: Image.network(product.images![0]),
        title: Text(
          product.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(currencyFormat(product.price),
            style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );

Widget loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
