import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laundry/signup.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  final List<Map<String, String>> faqData = [
    {
      'question': 'What payment methods are available?',
      'answer':
      'We accept a variety of payment methods including UPI, credit/debit cards, net banking, and digital wallets. This ensures a seamless and secure transaction experience for all users. Choose the option that suits you best at checkout.',
    },
    {
      'question': 'How does dynamic pricing work?',
      'answer':
      'Our dynamic pricing adjusts based on your selected city or pin code. This means you\'ll see the most accurate rates for your area. Simply enter your location to view local pricing.',
    },
    {
      'question': 'Can I schedule delivery?',
      'answer':
      'Yes, you can easily schedule your pickup and delivery using our calendar interface. Select your preferred dates and available time slots at your convenience. We also offer an urgent delivery option for faster service.',
    },
    {
      'question': 'Is my payment secure?',
      'answer':
      'Absolutely! We prioritize your security with a robust payment gateway that encrypts your information. You can also choose to save your cards for future transactions, making it even more convenient.',
    },
    {
      'question': 'How do I contact support?',
      'answer':
      'If you have any questions or need assistance, feel free to reach out to our support team. You can contact us through the \'Contact\' button above. We’re here to help you with any inquiries.',
    },
  ];

  final List<bool> _expanded = [];

  var emailText = TextEditingController();

  final List<Product> allProducts = [
    Product(
      name: 'Premium Wash',
      category: 'Wash Fold',
      fabric: 'Cotton',
      description: "Clothes are washed, dried, and neatly folded.",
      rating: 4.9,
      serviceMode: 'Pickup & Delivery',
      price: 50,
      priceUnit: 'kg',
      deliveryTime: '24 hours',
      imagePaths: 'assets/services/fold.png',
      popularity: 1000,
      dateAdded: DateTime(2025,7,1)
    ),
    Product(
      name: 'Silk Dry Clean',
      category: 'Dry Cleaning',
      fabric: 'Silk',
      description: "Specialized cleaning for delicate fabrics.",
      rating: 4.8,
      serviceMode: 'Home Service',
      price: 120,
      priceUnit: "item",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new1.png',
      popularity: 399,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Stain Removal',
      category: 'Stain Removal',
      fabric: 'Cotton',
      description: "Tough stain removal using fabric-safe methods.",
      rating: 5,
      serviceMode: 'Home Service',
      price: 30,
      priceUnit: "item",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new2.png',
      popularity: 500,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Wash',
      category: 'Wash & Fold',
      fabric: 'Silk',
      description: "Clothes are washed, dried, and neatly folded.",
      rating: 4.5,
      serviceMode: 'Home Service',
      price: 50,
      priceUnit: "kg",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new4.png',
      popularity: 800,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Iron',
      category: 'Ironing',
      fabric: 'Cotton,Silk',
      description: "Professional wrinkle-free ironing for all fabrics.",
      rating: 4.7,
      serviceMode: 'Home Service',
      price: 15,
      priceUnit: "item",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new5.png',
      popularity: 700,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Dry Clean',
      category: 'Dry Cleaning',
      fabric: 'Cotton, Silk',
      description: "Specialized cleaning for delicate fabrics.",
      rating: 4.8,
      serviceMode: 'Home Service',
      price: 120,
      priceUnit: "item",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new6.png',
      popularity: 600,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Dry Clean',
      category: 'Dry Cleaning',
      fabric: 'Silk',
      description: "Specialized cleaning for delicate fabrics.",
      rating: 4.8,
      serviceMode: 'Home Service',
      price: 120,
      priceUnit: "item",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new7.png',
      popularity: 600,
      dateAdded: DateTime(2025,6,10),
    ),
    Product(
      name: 'Fold',
      category: 'Wash & Fold',
      fabric: 'Silk',
      description: "Clothes are washed, dried, and neatly folded.",
      rating: 4.9,
      serviceMode: 'Home Service',
      price: 50,
      priceUnit: "kg",
      deliveryTime: '3+ days',
      imagePaths: 'assets/services/new8.png',
      popularity: 399,
      dateAdded: DateTime(2025,6,10),
    ),

  ];
  List<Product> filteredProducts = [];

  int currentIndex = 0;

  final List<String> numbers = List.generate(5, (index) => '${index + 1}');

  int currentPage = 0;
  int itemsPerPage = 8;
  List<Product> paginatedProducts = [];


  void goToNext() {
    int totalPages = (filteredProducts.length / itemsPerPage).ceil();
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
        _updatePaginatedProducts();
      });
    }
  }

  void goToPrevious() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        _updatePaginatedProducts();
      });
    }
  }
  void _updatePaginatedProducts() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    if (endIndex > filteredProducts.length) {
      endIndex = filteredProducts.length;
    }

    paginatedProducts = filteredProducts.sublist(startIndex, endIndex);
  }
  List<String> _generatePageNumbers() {
    int totalPages = (filteredProducts.length / itemsPerPage).ceil();
    if (totalPages == 0) totalPages = 1;
    return List.generate(totalPages, (index) => '${index + 1}');
  }

  Widget _pageButton(int index) {
    bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
          _updatePaginatedProducts();
        });
      },
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '${index + 1}'.padLeft(2, '0'),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            fontFamily: 'Inter',
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _arrowButton(bool isNext) {
    int totalPages = (filteredProducts.length / itemsPerPage).ceil();

    return InkWell(
      onTap: () {
        setState(() {
          if (isNext && currentPage < totalPages - 1) {
            currentPage++;
          } else if (!isNext && currentPage > 0) {
            currentPage--;
          }
          _updatePaginatedProducts();
        });
      },
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          isNext ? Icons.arrow_forward : Icons.arrow_back,
          size: 16,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }


  Set<String> selectedServiceCategories = {};
  Set<String> selectedFabrics = {};
  int selectedRating = 0;
  String selectedServiceMode = '';
  RangeValues priceRange = RangeValues(100, 10000);
  String selectedDeliveryTime = '';
  final Color primaryColor = const Color(0xFF1F3C5F);

  // Service Categories & Sub-options
  final Map<String, List<String>> serviceCategoryOptions = {
    'Wash Fold': ['Regular Wash', 'Premium Wash', 'Heavy Duty Wash'],
    'Dry Cleaning': [],
    'Ironing & Pressing': [],
    'Stain Removal': [],
    'Shoe Cleaning': [],
    'Carpet & Curtain Cleaning': [],
    'Health & Fitness': [],
  };

  final List<String> fabricTypes = ['Cotton', 'Silk', 'Wool', 'Denim', 'Delicate Fabrics'];
  final List<String> serviceModes = ['Pickup & Delivery', 'Walk-in Service', 'Home Service'];
  final List<String> deliveryTimes = ['Same day', '24 hours', '48 hours', '3+ days'];

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(top: 90, right: 16, left: 16, bottom: 90),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filters", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, fontFamily: 'Inter'),),
                    SizedBox(height: 30,),
                    const Text("Service Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ...serviceCategoryOptions.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            activeColor: primaryColor,
                            title: Text(entry.key),
                            value: selectedServiceCategories.contains(entry.key),
                            onChanged: (val) {
                              setModalState(() {
                                val == true
                                    ? selectedServiceCategories.add(entry.key)
                                    : selectedServiceCategories.remove(entry.key);
                              });
                            },
                          ),
                          if (selectedServiceCategories.contains(entry.key))
                            ...entry.value.map((subOption) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 32),
                                child: CheckboxListTile(
                                  title: Text(subOption),
                                  value: selectedServiceCategories.contains(subOption),
                                  onChanged: (val) {
                                    setModalState(() {
                                      val == true
                                          ? selectedServiceCategories.add(subOption)
                                          : selectedServiceCategories.remove(subOption);
                                    });
                                  },
                                ),
                              );
                            })
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    const Text("Fabric Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: fabricTypes.map((type) {
                        return FilterChip(
                          label: Text(type),
                          selected: selectedFabrics.contains(type),
                          onSelected: (selected) {
                            setModalState(() {
                              selected ? selectedFabrics.add(type) : selectedFabrics.remove(type);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                    const Text("Rating", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            color: selectedRating > index ? Colors.orange : Colors.grey,
                          ),
                          onPressed: () {
                            setModalState(() {
                              selectedRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 16),
                    const Text("Service Mode", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Column(
                      children: serviceModes.map((mode) {
                        return RadioListTile<String>(
                          activeColor: primaryColor,
                          title: Text(mode),
                          value: mode,
                          groupValue: selectedServiceMode,
                          onChanged: (val) {
                            setModalState(() {
                              selectedServiceMode = val!;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                    const Text("Price Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    RangeSlider(
                      activeColor: primaryColor,
                      values: priceRange,
                      min: 100,
                      max: 10000,
                      divisions: 20,
                      labels: RangeLabels(
                        "₹${priceRange.start.round()}",
                        "₹${priceRange.end.round()}",
                      ),
                      onChanged: (RangeValues values) {
                      setModalState(() {
                      priceRange = values;
                      });
                      },
                    ),
                    Text(
                      "Price: ₹${priceRange.start.round()} - ₹${priceRange.end.round()}",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Delivery Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      children: deliveryTimes.map((time) {
                        return ChoiceChip(
                          label: Text(time),
                          selected: selectedDeliveryTime == time,
                          onSelected: (selected) {
                            setModalState(() {
                              selectedDeliveryTime = selected ? time : '';
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _applyFilters();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.53),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                          backgroundColor: const Color(0xFF1F3C5F),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Apply Filters",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              height: 1.5
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _clearAllFilters();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.53),
                            side: const BorderSide(color: Colors.black, width: 1),
                          ),
                          backgroundColor: const Color(0xFF1F3C5F),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Remove Filter",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              height: 1.5
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _applyFilters() {
    bool hasActiveFilters = selectedServiceCategories.isNotEmpty ||
        selectedFabrics.isNotEmpty ||
        selectedRating > 0 ||
        selectedServiceMode.isNotEmpty ||
        selectedDeliveryTime.isNotEmpty ||
        (priceRange.start != 100 || priceRange.end != 10000) ||
        _searchController.text.isNotEmpty;

    List<Product> results;

    if (!hasActiveFilters) {
      // No filters active - show all products
      results = List.from(allProducts);
    } else {
      // Apply filters
      results = allProducts.where((product) {
        final matchesCategory = selectedServiceCategories.isEmpty ||
            selectedServiceCategories.contains(product.category) ||
            selectedServiceCategories.any((cat) => product.name.contains(cat));

        final matchesFabric = selectedFabrics.isEmpty ||
            selectedFabrics.any((fabric) => product.fabric.contains(fabric));

        final matchesRating = selectedRating == 0 ||
            product.rating >= selectedRating.toDouble();

        final matchesServiceMode = selectedServiceMode.isEmpty ||
            product.serviceMode == selectedServiceMode;

        final matchesPrice = product.price.toDouble() >= priceRange.start && product.price.toDouble() <= priceRange.end;

        final matchesDeliveryTime = selectedDeliveryTime.isEmpty ||
            product.deliveryTime == selectedDeliveryTime;

        final matchesSearch = _searchController.text.isEmpty ||
            product.name.toLowerCase().contains(_searchController.text.toLowerCase());

        return matchesCategory &&
            matchesFabric &&
            matchesRating &&
            matchesServiceMode &&
            matchesPrice &&
            matchesDeliveryTime &&
            matchesSearch;
      }).toList();
    }

    // Apply Sort
    if (trendingOption == 'Top Rated') {
      results.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (trendingOption == 'Most Popular') {
      results.sort((a, b) => b.popularity.compareTo(a.popularity));
    } else if (trendingOption == 'Recently Added') {
      results.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    }

    setState(() {
      filteredProducts = results;
      currentPage = 0;
      _updatePaginatedProducts();
    });
  }

  void _clearAllFilters() {
    setState(() {
      selectedServiceCategories.clear();
      selectedFabrics.clear();
      selectedRating = 0;
      selectedServiceMode = '';
      selectedDeliveryTime = '';
      priceRange = const RangeValues(100, 10000);
      _searchController.clear();
      _applyFilters();
    });
  }

  final TextEditingController _searchController = TextEditingController();

  final List<String> _allItems = [
    'Wash',
    'Iron',
    'Dry Clean',
    'Shoes Wash',
    'Heavy Wash',
    'Stain Removal',
    'Budget Friendly',
    'Premium Wash',
    'Regular Wash',
    'Carpet Cleaning',
    'Curtains',
    'Cotton',
    'Denim Wash',
  ];

  String trendingOption = 'Trending';

  final List<String> trendingOptions = [
    'Trending',
    'Most Popular',
    'Top Rated',
    'Recently Added',
  ];

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filteredProducts = List.from(allProducts);
    _updatePaginatedProducts();
    _expanded.addAll(List.filled(faqData.length, false));
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _isSearching = false;
      } else {
        _isSearching = true;
      }
      _applyFilters();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
    });
  }


  int currentphoto = 0;
  final List<PhotoData> photos = [
    PhotoData(image: 'assets/images/Image2.png',),
    PhotoData(image: 'assets/images/Placeholder2.png',),
  ];


  void nextphoto() {
    setState(() {
      currentphoto = (currentphoto + 1) % photos.length;
    });
  }

  void previousphoto() {
    setState(() {
      currentphoto = (currentphoto - 1 + photos.length) % photos.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPhoto = photos[currentphoto];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: AssetImage('assets/frames/Frame3.png'),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 267,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 46, left: 35),
                      height: 267,
                      child: Column(
                        children: [
                          Text("Our Laundry Services",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 29.33,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              color: Color(0xFF1F3C5F)
                            ),),
                          SizedBox(height: 7,),
                          Text("Premium-quality laundry services that make life easier—fresh, clean, and perfectly cared-for garments every time.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Color(0xFF1F3C5F)
                            ),),
                          SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 7.33, vertical: 3.67),
                                minimumSize: Size(101, 26),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.53),
                                  side: const BorderSide(color: Colors.black, width: 1),
                                ),
                                backgroundColor: const Color(0xFF1F3C5F),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Book a Service Now",
                                style: TextStyle(
                                  fontSize: 8.75,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.5
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 267,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 190.89,
                            child: ClipRRect(
                              child: Image.asset(
                                currentPhoto.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 9.78,),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.78),
                            child: Text("Fresh Clothes, Zero Hassle!",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                fontFamily: 'Roboto',
                                height:1.4,
                              ),),
                          ),
                          SizedBox(height: 1.22,),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.78),
                            child: Text("Professional Laundry & Dry Cleaning at Your Doorstep.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                                fontFamily: 'Roboto',
                                height:1.5,
                              ),),
                          ),
                          SizedBox(height: 3,),
                          Padding(
                            padding: const EdgeInsets.only(right: 9.56),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Previous button
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1F3C5F),
                                    borderRadius: BorderRadius.circular(19.54),
                                  ),
                                  child: IconButton(
                                    onPressed: previousphoto,
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
                                    borderRadius: BorderRadius.circular(19.54),
                                  ),
                                  child: IconButton(
                                    onPressed: nextphoto,
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 10.05,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/frames/Frame9.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.only(top: 40),
              width: 440,
              child: Column(
                children: [
                  Text("Our Laundry Services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 29.33,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: Color(0xFF1F3C5F)
                    ),),
                  Container(
                    padding: EdgeInsets.only(right: 18, left: 18, top: 38),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Services',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _isSearching
                            ?IconButton(
                            onPressed: _clearSearch,
                            icon: Icon(Icons.clear_rounded),
                        ):null,
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18,left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              OutlinedButton.icon(
                                onPressed: _openFilterBottomSheet,
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Color(0xFF7ED321), width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  padding: EdgeInsets.only(right: 16.58, left: 16.58),
                                ),
                              ),
                              SizedBox(width: 116.67),
                              Text(
                                "Sort by:",
                                style: TextStyle(
                                  fontSize: 9.41,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.4
                                ),
                              ),

                              SizedBox(width: 8),
                              Container(
                                height: 32,
                                width: 126,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, // Border color
                                    width: 1,         // Border width
                                  ),
                                ),
                                padding: EdgeInsets.only(right: 11, left: 11),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: trendingOption,
                                    isDense: true,
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 16),
                                    dropdownColor: Colors.white,
                                    style: TextStyle(
                                      fontSize: 10.76,
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      height: 1.6,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        trendingOption = newValue!;
                                        _applyFilters();
                                      });
                                    },
                                    items: trendingOptions.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),

                                    selectedItemBuilder: (BuildContext context) {
                                      return trendingOptions.map<Widget>((String value) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(value, overflow: TextOverflow.ellipsis),
                                            SizedBox(width: 4), // adjust this to control spacing
                                          ],
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 404,
                        child: filteredProducts.isEmpty
                            ? Center(child: Text('No products match your filters'))
                            : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: paginatedProducts.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final product = paginatedProducts[index];
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.zero,
                                    child: Image.asset(
                                      product.imagePaths,
                                      height: 145.77,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.98, vertical: 4.98),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(top: 2.49, right: 3.74, bottom: 2.49, left: 3.74),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFEEE8),
                                          ),
                                          child: Text(
                                            product.category.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF993D20),
                                              height: 1.4
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '₹${product.price}/${product.priceUnit}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            fontFamily: 'Inter'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      product.description ?? 'Tough stain removal using fabric-safe methods.',
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 0.62,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.orange, size: 12.46),
                                        const SizedBox(width: 4),
                                        Text(
                                          product.rating.toStringAsFixed(1),
                                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {

                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: const Size(61.05, 11.21),
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          child: const Row(
                                            children: [
                                              Text(
                                                'View Details',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 7.5,
                                                  height: 1.2
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios, size: 10, color: Colors.black87),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(height: 24.92,),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 5,
                        runSpacing: 8,
                        children: [
                          _arrowButton(false), // Prev
                          ...List.generate(_generatePageNumbers().length, (index) => _pageButton(index)),
                          _arrowButton(true),  // Next
                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 31.8,),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/frames/Frame8.png"),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 33,),
                  Padding(
                    padding: const EdgeInsets.only(right: 48, left: 48),
                    child: Text("Explore Our Comprehensive Service Offerings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: Color(0xFF1F3C5F)
                        ),),
                  ),
                  SizedBox(height: 7.33,),
                  Padding(
                    padding: const EdgeInsets.only(right: 48, left: 48),
                    child: Text("We provide a range of services tailored to meet your needs. From seamless payment integration to efficient delivery scheduling, we've got you covered.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 9.8,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            letterSpacing: 0,
                            color: Colors.black
                        ),),
                  ),
                  SizedBox(height: 35.67,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 66, left: 66),
                    child: Column(
                      children: [
                        Image.asset("assets/images/Placeholder4.png", width: 308, height: 152,),
                        SizedBox(height: 10,),
                        Text("Flexible Payment Options for Everyone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              height: 1.3,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700
                          ),),
                        SizedBox(height: 7.33,),
                        Text("Choose from various payment methods, including UPI, cards, and wallets.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Roboto',
                                height: 1.5,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400
                            ),),
                        SizedBox(height: 7,),
                        Image.asset("assets/images/Placeholder5.png", width: 308, height: 152,),
                        SizedBox(height: 10,),
                        Text("Dynamic Pricing for Localized Rates",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              height: 1.3,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700
                          ),),
                        SizedBox(height: 7.33,),
                        Text("Get real-time pricing updates based on your location.",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Roboto',
                                height: 1.5,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400
                            ),),
                        SizedBox(height: 7,),
                        Image.asset("assets/images/Placeholder6.png", width: 308, height: 152,),
                        SizedBox(height: 10,),
                        Text("Convenient Scheduling for Pickup and Delivery",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              height: 1.3,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700
                          ),),
                        SizedBox(height: 7.33,),
                        Text("Select your preferred dates and time slots easily.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Roboto',
                                height: 1.5,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400
                            ),),
                        SizedBox(height: 36,),
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
                        SizedBox(height: 33,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(right: 19.56, left: 19.56, top: 33),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Join Us for \nExclusive Offers",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          fontFamily: 'Roboto',
                          color: Color(0xFF1F3C5F),
                        ),),
                      SizedBox(height: 7.33,),
                      Text("Sign up today to unlock special discounts \nand streamline your payment experience \nwith us.",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),),
                      SizedBox(height: 9.78,),
                      Row(
                        children: [
                          SizedBox(
                            width: 147.04,
                            height: 20,
                            child: TextFormField(
                              controller: emailText,
                              style: TextStyle(fontSize: 7, fontFamily: 'Roboto'),
                              decoration: InputDecoration(
                                hintText: 'Enter Email-Id',
                                hintStyle: TextStyle(fontSize: 7, fontFamily: 'Roboto'),
                                contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          SizedBox(
                            height: 20,
                            width: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Signup()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 4.48, right: 8.96, left: 8.96, bottom: 4.48),
                                backgroundColor: Color(0xFF1F3C5F),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.87),
                                  side: BorderSide(color: Colors.black, width: 0.37),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 7,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.97,),
                      RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 6,
                              fontFamily: 'Roboto',
                              height: 1.5,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: "By clicking Sign Up you're confirming that you agree with \nour "),
                              TextSpan(
                                text: "Terms and Conditions",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){

                                  },
                              ),
                            ],
                          )),
                      SizedBox(height: 30,),
                    ],
                  ),
                  SizedBox(width: 24.44,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.92),
                    child: Image.asset("assets/images/Placeholder7.png", width: 162.77, height: 122.22,),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/frames/Frame7.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.only(top: 34.22, left: 75, right: 75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("FAQs",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3C5F),
                    ),),
                  SizedBox(height: 7.33,),
                  Text("Find answers to your most pressing questions about our \npayment and delivery services.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),),
                  SizedBox(height: 24.44,),
                  ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: faqData.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                          height: 20,
                        ),
                        itemBuilder: (context, index) {
                          final item = faqData[index];
                          final isExpanded = _expanded[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _expanded[index] = !_expanded[index];
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['question']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    AnimatedRotation(
                                      duration: const Duration(milliseconds: 200),
                                      turns: isExpanded ? 0.5 : 0.0,
                                      child: const Icon(Icons.expand_more,size: 9.78,),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 200),
                                firstChild: const SizedBox.shrink(),
                                secondChild: Text(
                                  item['answer']!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: 1.5,
                                    fontFamily: 'Roboto'
                                  ),
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                              ),
                            ],
                          );
                        },
                      ),
                  SizedBox(height: 24.44,),
                  Text("Still have questions?",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1.3,
                      fontFamily: 'Roboto'
                    ),),
                  SizedBox(height: 4.89,),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        height: 1.5,
                        fontFamily: 'Roboto'
                    ),),
                  SizedBox(height: 5,),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(20, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.11),
                        side: const BorderSide(color: Color(0xFF7ED321), width: 1),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                    child: const Text(
                      "Contact",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 10
                      ),
                    ),
                  ),
                  SizedBox(height: 34.22,),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(right: 11.31, left: 19.56, top: 33),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Stay Updated with \nOur Newsletter",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          fontFamily: 'Roboto',
                          color: Color(0xFF1F3C5F),
                        ),),
                      SizedBox(height: 7.33,),
                      Text("Lorem ipsum dolor sit amet, consectetur ",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),),
                      SizedBox(height: 9.78,),

                      SizedBox(height: 30,),
                    ],
                  ),
                  SizedBox(width: 9.78,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 121,
                            height: 20,
                            child: TextFormField(
                              controller: emailText,
                              style: TextStyle(fontSize: 7, fontFamily: 'Roboto'),
                              decoration: InputDecoration(
                                hintText: 'Enter Email Here',
                                hintStyle: TextStyle(fontSize: 7, fontFamily: 'Roboto'),
                                contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.37),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.89),
                          SizedBox(
                            height: 20,
                            width: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Signup()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 4.48, right: 8.96, left: 8.96, bottom: 4.48),
                                backgroundColor: Color(0xFF1F3C5F),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.87),
                                  side: BorderSide(color: Colors.black, width: 0.37),
                                ),
                              ),
                              child: Text(
                                "Join Us",
                                style: TextStyle(
                                  fontSize: 7,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.97,),
                      RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 6,
                              fontFamily: 'Roboto',
                              height: 1.5,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: "By clicking Sign Up you're confirming that you agree with \nour "),
                              TextSpan(
                                text: "Terms and Conditions",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){

                                  },
                              ),
                            ],
                          )),
                    ],
                  ),


                ],
              ),
            ),

      ],
        ),
      ),
    );
  }
}
class PhotoData {
  final String image;

  PhotoData({
    required this.image,
  });
}
class Product {
  final String name;
  final String category;
  final String fabric;
  final String description;
  final double rating;
  final String serviceMode;
  final int price;
  final String priceUnit;
  final String deliveryTime;
  final String imagePaths;
  final int popularity;
  final DateTime dateAdded;

  Product({
    required this.name,
    required this.category,
    required this.fabric,
    required this.description,
    required this.rating,
    required this.serviceMode,
    required this.price,
    required this.priceUnit,
    required this.deliveryTime,
    required this.imagePaths,
    required this.popularity,
    required this.dateAdded,
  });
}


