import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/shopping.dart';
import 'package:shop_app/pages/cart_page.dart';

class ShoppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  const ShoppAppBar({super.key, required this.appbarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.pink[200],
          title: Text(
            appbarTitle,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: Stack(
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      color: Colors.brown[100], size: 28),
                  Positioned(
                    child: Badge(
                      label: Text(Provider.of<Shopping>(context, listen: false)
                          .userCart
                          .length
                          .toString()),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
  }
  
  @override
  // TODO: implement preferredSize
@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}