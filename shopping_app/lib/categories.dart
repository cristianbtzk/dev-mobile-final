import 'package:flutter/material.dart';
import 'package:shopping_app/apiRequests/dummyJson/endpoints.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/navigationbar.dart';
import 'package:shopping_app/products.dart';
import 'package:shopping_app/utils/capitalize.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State {
  Future<List<String>>? categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.blue.shade400,
      ),
      drawer: const CustomNavigationBar(),
      body: FutureBuilder(
        future: categories,
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
                      child: ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              capitalize(snapshot.data[index]),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: ProductsScreenParams(
                                  category: snapshot.data[index],
                                ),
                              );
                            },
                          );
                        },
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
          categories = getCategoriesList();
        });
      }
    });
    super.initState();
  }
  /* Widget generateColum(Product product) => Card(
        child: ListTile(
          leading: Image.network(product.images![0]),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle:
              Text(item.tagline, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ); */
}

Widget loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
