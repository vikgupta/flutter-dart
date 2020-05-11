import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import '../screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, dataSnapshot) {
          if( dataSnapshot.connectionState == ConnectionState.waiting ) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(dataSnapshot.error != null) {
              // Do error handling stuff
              return Center(
                child: Text('Error while fetching products that you manage!'),
              );
            } else {
              return Consumer<Products>(
                builder: (ctx, products, child) => RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: products.items.length,
                      itemBuilder: (ctx, index) => Column(
                        children: <Widget>[
                          UserProductItem(products.items[index].id, products.items[index].title, products.items[index].imageUrl),
                          Divider(),
                        ],
                      )
                    )
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}