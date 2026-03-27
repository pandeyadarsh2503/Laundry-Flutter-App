import 'package:flutter/material.dart';
import 'package:laundry/home_page.dart';
import 'package:laundry/pickup_page.dart';
import 'package:laundry/pricing_page.dart';
import 'package:laundry/schedule_pickup.dart';
import 'package:laundry/service_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => MainShellState();
}

class MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  List<Widget> icons = [
    Icon(Icons.home_rounded),
    Icon(Icons.calendar_month_outlined),
    Image.asset("assets/icons/Order.png"),
    Icon(Icons.person_outline_outlined),

  ];

  List<Widget> pages = [
    HomePage(),
    ServicePage(),
    PricingPage(),
    PickupPage(),
    SchedulePickup()
    // add mew fun here



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // make it taller
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/LOGO.png',
                  height: 70,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu_outlined),
                  onPressed: () {},
                ),
                SizedBox(width: 4),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                )
              ],
            ),
          ],
        ),
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 40, offset: Offset(0, 10))],
            borderRadius: BorderRadius.circular(13.76),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(icons.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200), // Fixed: was microseconds
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF1F3C5F) : Colors.transparent,
                    borderRadius: BorderRadius.circular(13.76),
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    child: icons[index],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}