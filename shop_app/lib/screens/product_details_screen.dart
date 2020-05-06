import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title)
      ),
      body: Center(
        child: Text(
          'DEF'
        )
      ),
    );
  }
}