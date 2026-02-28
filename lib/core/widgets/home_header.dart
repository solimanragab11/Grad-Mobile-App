import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            // فتح الـ Drawer عند الضغط على أيقونة المنيو (بديل للأيقونات الكتيرة)
            IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Colors.blue,
                size: w * 0.08,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),

            SizedBox(
              width: w * 0.75,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // زرار اللغة الزجاجي
          ],
        ),
      ),
    );
  }
}
