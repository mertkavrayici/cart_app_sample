import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imagePath;
  final int? price;
  const ProductContainer(
      {super.key,
      required this.onTap,
      required this.title,
      required this.imagePath,
      this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            leading: Image.asset(
              imagePath,
              width: 100,
            ),
            subtitle: price != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("$price TL",
                        style: const TextStyle(color: Colors.brown)),
                  )
                : const SizedBox(),
            trailing:price==null ? Icon(
              Icons.navigate_next,
              color: Colors.pink[300],
            ) : Icon(
              Icons.add,
              color: Colors.pink[300],
            ),
          ),
        ),
      ),
    );
  }
}
