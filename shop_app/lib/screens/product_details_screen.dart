import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
//import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(productId);
    
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(product.title)
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${product.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800,
              ),
            ]),
          )
        ],
      ),
    );
  }
}