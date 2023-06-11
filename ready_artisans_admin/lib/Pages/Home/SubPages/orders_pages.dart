import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: size.width,
            height: size.width > 800 ? 100 : 30,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(children: [
              if (size.width <= 800)
                Text(
                  'Home/Orders',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              if (size.width > 800)
                Image.asset(
                  'assets/images/logo_h_t.png',
                ),
              const SizedBox(
                width: 50,
              ),
              const Spacer(),
              if (size.width > 800)
                Text(
                  'Home/Orders',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                )
            ]),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
