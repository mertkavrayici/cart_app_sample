import 'package:flutter/material.dart';
import 'package:shop_app/components/button.dart';
import 'package:shop_app/pages/categories_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
                Center(
                child: Text(
              "Alışveriş Uygulaması",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[200]),
            )),
            Center(
                child: Image.asset(
              "lib/images/mall.png",
              height: 350,
            )),
            const SizedBox(
              height: 50,
            ),
        
            const SizedBox(
              height: 20,
            ),
          
            const SizedBox(
              height: 50,
            ),
            ShoppingButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoriesPage()),
                  );
                },
                text: "Giriş Yap")
          ],
        ));
  }
}
