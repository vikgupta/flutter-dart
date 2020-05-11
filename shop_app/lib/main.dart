import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth()
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.userId,
            auth.token, 
            previousProducts == null ? [] : previousProducts.items
          ),
          create: (ctx) => Products(null, null, [])
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart()
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.userId,
            auth.token, 
            previousOrders == null ? [] : previousOrders.orders
          ),
          create: (ctx) => Orders(null, null, [])
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          //home: MyHomePage(),
          routes: {
            '/': (ctx) => auth.isAuthenticated ? ProductsOverviewScreen() : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (context, dataSnapshot) {
                if( dataSnapshot.connectionState == ConnectionState.waiting ) {
                  return SplashScreen();
                } else {
                  return AuthScreen();
                }
              },
            ),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      )
    );
  }
}