import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PricingPage()));

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final PageController _pageController = PageController(viewportFraction: 0.75, initialPage: 1);
  int _currentPage = 1;
  bool _isMonthly = true;

  final List<Map<String, dynamic>> _plans = [
    {
      'title': 'Basic Plan',
      'price': {'monthly': '199', 'yearly': '1999'},
      'features': [
        'Wash & Fold (5kg limit)',
        'Next-Day Delivery',
        'Basic Stain Removal'
      ]
    },
    {
      'title': 'Premium Plan',
      'price': {'monthly': '499', 'yearly': '4999'},
      'features': [
        'Wash, Fold & Iron (Unlimited)',
        'Same-Day Delivery',
        'Advanced Stain Removal',
        'Free Pickup & Delivery'
      ]
    },
    {
      'title': 'Elite Plan',
      'price': {'monthly': '999', 'yearly': '9999'},
      'features': [
        'All Premium Features',
        'Customized Care',
        'Dedicated Account Manager',
        'Priority Service'
      ]
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 37),
              color: Color(0xFFF5F7EB),
              child: Column(
                children: [
                  Text(
                    "Choose Your Monthly\nLaundry Plan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3C5F),
                      height: 1.2,
                      letterSpacing: 0
                    ),
                  ),
                  const SizedBox(height: 3.06),
                  Text(
                    "Flexible monthly plans tailored to your laundry needs. Pick the perfect one for you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[700],
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0
                    ),
                  ),
                  const SizedBox(height: 14.06),
                  ToggleButtons(
                    isSelected: [_isMonthly, !_isMonthly],
                    onPressed: (int index) {
                      setState(() => _isMonthly = index == 0);
                    },
                    borderRadius: BorderRadius.circular(0),
                    selectedColor: Colors.white,
                    renderBorder: true,
                    fillColor: const Color(0xFF1F3C5F),
                    borderColor: const Color(0xFF1F3C5F),
                    selectedBorderColor: const Color(0xFF1F3C5F),
                    constraints: const BoxConstraints(minHeight: 25, minWidth: 50),
                    children: [
                      Container(color: !_isMonthly ? Colors.white : null,height: 25, width:50,alignment: Alignment.center,child: Text("Monthly", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.5, fontFamily: 'Roboto'),)),
                      Container(color: _isMonthly ? Colors.white : null,height: 25, width:50,alignment: Alignment.center, child: Text("Yearly",style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.5, fontFamily: 'Roboto')))
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 420,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _plans.length,
                      onPageChanged: (int page) => setState(() => _currentPage = page),
                      itemBuilder: (context, index) {
                        final plan = _plans[index];
                        final isFocused = index == _currentPage;
                        return AnimatedScale(
                          scale: isFocused ? 1.0 : 0.9,
                          duration: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Card(
                              elevation: isFocused ? 12 : 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: isFocused
                                    ? BorderSide(color: Color(0xFF1F3C5F), width: 2)
                                    : BorderSide.none,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: isFocused
                                      ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.white, Color(0xFFF8F9FA)],
                                  )
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (index == 1)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1F3C5F),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "MOST POPULAR",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      if (index == 1) const SizedBox(height: 12),
                                      Text(
                                        plan['title'],
                                        style: TextStyle(
                                          fontSize: 34.88,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F3C5F),
                                        ),
                                      ),
                                      const SizedBox(height: 3.28),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            "₹${plan['price'][_isMonthly ? 'monthly' : 'yearly']}",
                                            style: TextStyle(
                                              fontSize: 32.2,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1F3C5F),
                                            ),
                                          ),
                                          Text(
                                            _isMonthly ? "/mo": "/yr",
                                            style: TextStyle(
                                              fontSize: 16.1,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (!_isMonthly)
                                        Text(
                                          "Save ${((double.parse(plan['price']['monthly']) * 12 - double.parse(plan['price']['yearly'])) / (double.parse(plan['price']['monthly']) * 12) * 100).round()}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green[600],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      const SizedBox(height: 20),
                                      ...plan['features'].map<Widget>((f) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1F3C5F),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                  Icons.check,
                                                  size: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                f,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[800],
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle plan selection
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Selected ${plan['title']}'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF1F3C5F),
                                          foregroundColor: Colors.white,
                                          minimumSize: const Size(double.infinity, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          elevation: 2,
                                        ),
                                        child: Text(
                                            "Get Started",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _plans.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentPage ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == _currentPage
                              ? Color(0xFF1F3C5F)
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Experience the Power of  FreshFold!",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Roboto-Medium",
                      height: 1,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1
                    ),),
                  SizedBox(height: 12.83,),
                  Text("Enjoy a month of hassle-free laundry with FreshFold. Try any \nplan for FREE and discover the convenience you deserve!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Roboto-Light",
                      letterSpacing: 0.08,
                      height: 1
                    ),),
                  SizedBox(height: 20.47,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.31,
                        width: 95.37,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.02),
                              side: const BorderSide(color: Color(0xFFA9E26A), width: 0.4),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: EdgeInsets.symmetric(vertical: 6.06, horizontal: 11.72)
                          ),
                          child: const Text(
                            "Try Yourself",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 8.89,
                              fontWeight: FontWeight.w400,
                              height: 1,
                              letterSpacing: 0
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 9.29),
                      SizedBox(
                        height: 30.31,
                        width: 95.37,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(color: Colors.black, width: 1),
                            ),
                            backgroundColor: const Color(0xFF1F3C5F),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 6.06, horizontal: 11.72)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Get Started",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 8.89,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 4,),
                              Image.asset(
                                'assets/icons/arrow_upright.png',
                                height: 7.88,
                                width: 7.88,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 29.39,)
                ],
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}