import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laundry/main_shell.dart';
import 'package:laundry/schedule_pickup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<String> imagePaths = [
    'assets/images/iron.png',
    'assets/images/machine.png',
    'assets/images/clothes.png',
    'assets/images/wm.png',
    'assets/images/blanket.png',
    'assets/images/suit.png',
  ];

  Widget buildFeatureCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 57, left: 57),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            child: SizedBox(
              height: 152,
              width: 294,
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              fontFamily: 'Roboto',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              fontFamily: 'Roboto',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  bool isUserScrolling = false;
  Timer? autoScrollTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start auto-scrolling after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_scrollController.hasClients && !isUserScrolling) {
          final maxScroll = _scrollController.position.maxScrollExtent;
          final currentScroll = _scrollController.offset;
          double nextScroll = currentScroll + 90; // item width + margin

          if (nextScroll >= maxScroll) {
            nextScroll = 0; // Scroll back to start
          }

          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    autoScrollTimer?.cancel();
    super.dispose();
  }

  int currentReviewIndex = 0;
  final List<ReviewData> reviews = [
    ReviewData(
      image: 'assets/images/Placeholder3.png',
      rating: 5,
      reviewText: 'Fast, friendly, and eco-conscious! I recommend them to everyone I know.',
      customerName: 'David Brown',
      customerTitle: 'Tech Lead, Innovate',
    ),
    ReviewData(
      image: 'assets/images/Placeholder2.png',
      rating: 4,
      reviewText: 'Great service and quality products. Very satisfied with my purchase.',
      customerName: 'Sarah Johnson',
      customerTitle: 'Marketing Manager, TechCorp',
    ),
  ];

  void nextReview() {
    setState(() {
      currentReviewIndex = (currentReviewIndex + 1) % reviews.length;
    });
  }

  void previousReview() {
    setState(() {
      currentReviewIndex = (currentReviewIndex - 1 + reviews.length) % reviews.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentReview = reviews[currentReviewIndex];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    "Hassle-Free Laundry Service \n at your Doorstep!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3C5F),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.only(right: 35, left: 35),
                    child: Text(
                      "We pick up, wash, and deliver your clothes fresh and clean. Experience the convenience of laundry service tailored to your busy lifestyle.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Use a callback to update the MainShell selectedIndex
                          final state = context.findAncestorStateOfType<MainShellState>();
                          state?.setState(() {
                            state.selectedIndex = 4; // ⬅️ Index of SchedulePickup in `pages`
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                          backgroundColor: const Color(0xFF1F3C5F),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Schedule a Pickup",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // final state = context.findAncestorStateOfType<MainShellState>();
                          // state?.setState(() {
                          //   state.selectedIndex = 5; // ⬅️ Index of SchedulePickup in `pages`
                          // });

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                        child: const Text(
                          "Pickup",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22.14),
                  SizedBox(
                    height: 80,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                          setState(() => isUserScrolling = true);
                        } else if (scrollNotification is ScrollEndNotification) {
                          setState(() => isUserScrolling = false);
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          final isFloating = index % 2 == -1;
                          return AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              double offsetY = isFloating ? -_animation.value : 0;
                              return Transform.translate(
                                offset: Offset(0, offsetY),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: isFloating
                                        ? [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 3),
                                      ),
                                    ]
                                        : [],
                                    image: DecorationImage(
                                      image: AssetImage(imagePaths[index % imagePaths.length]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 34.89),
                  const Padding(
                    padding: EdgeInsets.only(right: 29, left: 29),
                    child: Text(
                      "Why Our Laundry Service Stands Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        color: Color(0xFF1F3C5F),
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Padding(
                    padding: EdgeInsets.only(right: 29, left: 29),
                    child: Text(
                      "Experience the convenience of our laundry service. We prioritize your needs with our reliable and efficient solutions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.11),
                  buildFeatureCard(
                    imagePath: 'assets/images/basket.png',
                    title: 'Free Pickup & Delivery Right to your Door',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare, eros dolor interdum nulla.',
                  ),
                  const SizedBox(height: 12),
                  buildFeatureCard(
                    imagePath: 'assets/images/Placeholder1.png',
                    title: 'Affordable Pricing with No Hidden Fees',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare, eros dolor interdum nulla.',
                  ),
                  const SizedBox(height: 12),
                  buildFeatureCard(
                    imagePath: 'assets/images/Placeholder2.png',
                    title: 'Eco-Friendly Products for a Greener Clean',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare, eros dolor interdum nulla.',
                  ),
                  const SizedBox(height: 52.89),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.11),
                            side: const BorderSide(color: Color(0xFF7ED321), width: 1),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                        child: const Text(
                          "Learn More",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.11),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_ios_rounded, size: 14.91),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Container(
                    padding: const EdgeInsets.only(top: 37),
                    width: double.infinity,
                    height: 618,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/frames/Frame1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Simple Steps to Fresh, Clean Laundry",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F3C5F),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            height: 1.5,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 37.56),
                        Padding(
                          padding: const EdgeInsets.only(left: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  Text(
                                    "Schedule Your Pickup",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    "Select a time that works \n best for you.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      height: 1.5,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/Group8.png',
                                height: 96.17,
                                width: 96.17,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 29.37),
                        Padding(
                          padding: const EdgeInsets.only(right: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/Group9.png',
                                height: 96.17,
                                width: 96.17,
                              ),
                              const Column(
                                children: [
                                  Text(
                                    "We Handle the Cleaning",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    "Our experts will wash and dry clean \n your fabrics.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      height: 1.5,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 29.37),
                        Padding(
                          padding: const EdgeInsets.only(left: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  Text(
                                    "Enjoy Fast Delivery",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    "Receive your freshly cleaned \n clothes right at home.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      height: 1.5,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/Group10.png',
                                height: 96.17,
                                width: 96.17,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.11),
                                  side: const BorderSide(color: Color(0xFF7ED321), width: 1),
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                              ),
                              child: const Text(
                                "Get Started",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.11),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Learn More",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.arrow_forward_ios_rounded, size: 14.91),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 21,),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 264,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/frames/Frame2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 34.22, right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side - Image
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  currentReview.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24.44),
                          // Right side - Review content
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Star rating
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < currentReview.rating ? Icons.star : Icons.star_border,
                                      color: const Color(0xFFEDB600),
                                      size: 13,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 10.33),
                                // Review text
                                Text(
                                  '"${currentReview.reviewText}"',
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 9.82),
                                // Customer info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentReview.customerName,
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF000000),
                                        height: 1.5,
                                      ),
                                    ),
                                    Text(
                                      currentReview.customerTitle,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 37.25),
                                // Navigation arrows
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Previous button
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F3C5F),
                                        borderRadius: BorderRadius.circular(20.93),
                                      ),
                                      child: IconButton(
                                        onPressed: previousReview,
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 10.05,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6.7),
                                    // Next button
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F3C5F),
                                        borderRadius: BorderRadius.circular(20.93),
                                      ),
                                      child: IconButton(
                                        onPressed: nextReview,
                                        icon: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 10.05,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewData {
  final String image;
  final int rating;
  final String reviewText;
  final String customerName;
  final String customerTitle;

  ReviewData({
    required this.image,
    required this.rating,
    required this.reviewText,
    required this.customerName,
    required this.customerTitle,
  });
}