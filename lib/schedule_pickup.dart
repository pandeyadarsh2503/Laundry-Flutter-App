import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePickup extends StatefulWidget {
  const SchedulePickup({super.key});

  @override
  State<SchedulePickup> createState() => _SchedulePickupState();
}

class _SchedulePickupState extends State<SchedulePickup> {

  final List<Product> allProducts = [
    Product(
        name: 'Premium Wash',
        category: 'Wash Fold',
        fabric: 'Cotton',
        description: "Clothes are washed, dried, and neatly folded.",
        price: "50/kg", imagePaths: 'assets/services/fold.png',
    ),
    Product(
      name: 'Silk Dry Clean',
      category: 'Dry Cleaning',
      fabric: 'Silk',
      description: "Specialized cleaning for delicate fabrics.",
      price: "120/item", imagePaths: 'assets/services/new1.png',
    ),
    Product(
      name: 'Stain Removal',
      category: 'Stain Removal',
      fabric: 'Cotton',
      description: "Tough stain removal using fabric-safe methods.",
      price: "30/item", imagePaths: 'assets/services/new2.png',
    ),
    Product(
      name: 'Wash',
      category: 'Wash & Fold',
      fabric: 'Silk',
      description: "Clothes are washed, dried, and neatly folded.",
      price: "50/kg", imagePaths: 'assets/services/new4.png',
    ),
    Product(
      name: 'Iron',
      category: 'Ironing',
      fabric: 'Cotton,Silk',
      description: "Professional wrinkle-free ironing for all fabrics.",
      price: "15/item", imagePaths: 'assets/services/new5.png',
    ),

  ];


  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _deliverydateController = TextEditingController();
  var address = TextEditingController();
  var landmark = TextEditingController();
  var name = TextEditingController();
  var title = TextEditingController();
  var promo = TextEditingController();
  String? _selectedTimeSlot;
  String? _deliveryselectedTimeSlot;

  List<String> deliverytimeSlots = [
    '9:00 AM - 11:00 AM',
    '11:00 AM - 1:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
  ];

  List<String> timeSlots = [
    '9:00 AM - 11:00 AM',
    '11:00 AM - 1:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _deliverypickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _deliverydateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  List<Product> get selectedProducts =>
      allProducts.where((product)=>product.quantity>0).toList();

  int calculateSubtotal() {
    return selectedProducts.fold(0, (sum, p) {
      final unitPrice = int.tryParse(p.price.split('/')[0]) ?? 0;
      return sum + (unitPrice * p.quantity);
    });
  }

  int calculateDiscount() {
    return (calculateSubtotal() * 0.05).round();
  }

  int calculateTotal() {
    return calculateSubtotal() - calculateDiscount() + 20;
  }

  Widget summaryRow(String label, String value, {bool isBold = false, TextStyle? customStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              fontFamily: 'Roboto',
              height: 1,
              letterSpacing: 0,
              color: Color(0x99000000)
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: label.contains("Discount") ? Colors.red : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                fontFamily: 'Roboto',
                height: 1,
                letterSpacing: 0
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            height: 257,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 50, left: 21, right: 8),
                      height: 257,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Convenient Laundry at\nYour Doorstep!",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                letterSpacing: 0,
                                fontSize: 29.33,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                color: Color(0xFF1F3C5F),

                            ),),
                          SizedBox(height: 13.14,),
                          Text("Schedule your laundry pickup and delivery in just a few clicks!",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                height: 1.5,
                                color: Color(0xFF1F3C5F)
                            ),),
                        ],
                      )
                  ),
                ),
                Container(
                    height: 257,
                    width: 202,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 202,
                          height: 257,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/images/Group1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/frames/Frame9.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter
              ),
            ),
            padding: EdgeInsets.only(top: 27.36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Pickup Information",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3C5F),
                      letterSpacing: 0
                    ),),
                ),
                SizedBox(height: 21,),
                Container(
                  padding: EdgeInsets.only(left: 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  text: 'Address',
                                  style: TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red)
                                    )
                                  ]
                              )),
                              SizedBox(height: 7.88,),
                              Container(
                                width: 134.75,
                                height: 21.48,
                                child: TextField(
                                  style: TextStyle(fontSize: 7,),
                                  controller: address,
                                  decoration: InputDecoration(
                                    hintText: 'House Number / Flat / Block No.',
                                    hintStyle: TextStyle(fontSize: 7, fontFamily: 'Inter', letterSpacing: 0),
                                    filled: true,
                                    fillColor: Color(0x1AF7F7F7),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 7.7),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20.47,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  text: 'Landmark',
                                  style: TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red)
                                    )
                                  ]
                              )),
                              SizedBox(height: 7.88,),
                              Container(
                                width: 134.75,
                                height: 21.48,
                                child: TextField(
                                  style: TextStyle(fontSize: 7,),
                                  controller: landmark,
                                  decoration: InputDecoration(
                                    hintText: 'e.g. Near ABC School',
                                    hintStyle: TextStyle(fontSize: 7, fontFamily: 'Inter', letterSpacing: 0),
                                    filled: true,
                                    fillColor: Color(0x1AF7F7F7),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 7.7),
                                    // isCollapsed: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 13.75,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  text: 'Full Name',
                                  style: TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red)
                                    )
                                  ]
                              )),
                              SizedBox(height: 7.88,),
                              Container(
                                width: 134.75,
                                height: 21.48,
                                child: TextField(
                                  style: TextStyle(fontSize: 7,),
                                  controller: name,
                                  decoration: InputDecoration(
                                    hintText: 'your name',
                                    hintStyle: TextStyle(fontSize: 7, fontFamily: 'Inter', letterSpacing: 0),
                                    filled: true,
                                    fillColor: Color(0x1AF7F7F7),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 7.7),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20.47,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  text: 'Address Title',
                                  style: TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red)
                                    )
                                  ]
                              )),
                              SizedBox(height: 7.88,),
                              Container(
                                width: 134.75,
                                height: 21.48,
                                child: TextField(
                                  style: TextStyle(fontSize: 7,),
                                  controller: title,
                                  decoration: InputDecoration(
                                    hintText: 'e.g. Home',
                                    hintStyle: TextStyle(fontSize: 7, fontFamily: 'Inter', letterSpacing: 0),
                                    filled: true,
                                    fillColor: Color(0x1AF7F7F7),
                                    contentPadding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 7.7),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.86),
                                      borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 13.75,),
                      RichText(
                        text: TextSpan(
                          text: 'Pickup Date',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.black, fontFamily: 'Inter'),
                          children: [TextSpan(text: '*', style: TextStyle(color: Colors.red))],
                        ),
                      ),
                      SizedBox(height: 2,),
                      GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          width: 104.5,
                          height: 24,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(2.86),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _dateController.text.isEmpty ? 'Pick a date' : _dateController.text,
                                style: TextStyle(
                                  fontSize: 7,
                                  color: _dateController.text.isEmpty ? Colors.grey : Colors.black,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, size: 10),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: 'Pickup Time Slot',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.black, fontFamily: 'Inter'),
                          children: [TextSpan(text: '*', style: TextStyle(color: Colors.red))],
                        ),
                      ),
                      SizedBox(height: 2,),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isDense: true,
                          isExpanded: false,
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down, size: 10),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 100,
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          buttonStyleData: ButtonStyleData(
                            height: 21.48,
                            width: 104.5,
                            padding: EdgeInsets.symmetric(horizontal: 7.7),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300, width: 0.37),
                              borderRadius: BorderRadius.circular(2.86),
                            ),
                          ),
                          hint: Text('Pick a time slot',
                              style: TextStyle(fontSize: 7, fontFamily: 'Inter')),
                          value: _selectedTimeSlot,
                          items: timeSlots.map((slot) {
                            return DropdownMenuItem<String>(
                              value: slot,
                              child: Text(slot,
                                  style: TextStyle(fontSize: 7, fontFamily: 'Inter')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTimeSlot = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 54.2,),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/frames/Frame4.png'),
                fit: BoxFit.fill
              ),
            ),
            padding: EdgeInsets.only(top:26,right: 45, left: 45),
            child: Column(
              children: [
                Center(
                  child: Text("Select Your Service", style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    letterSpacing: 0,
                    color: Color(0xFF1F3C5F)
                  ),),
                ),
                SizedBox(height: 19,),
                Container(
                  padding: EdgeInsets.only(right: 7.33, left: 7.33, top: 7.64,),
                  width: 350,
                  height: 374,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: allProducts.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              final product = allProducts[index];
                              return Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 167,
                                          height: 57.55,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            elevation: 2,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(0),
                                                  child: Image.asset(product.imagePaths, width: 49.65, height: 57.17, fit: BoxFit.cover,),
                                                ),
                                                SizedBox(width: 6.89),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
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
                                                                  fontSize: 3.76,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Color(0xFF993D20),
                                                                  height: 1.4,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '₹${product.price}',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 6.77,
                                                                fontFamily: 'Inter',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5,),
                                                        child: Text(
                                                          product.description ?? 'Tough stain removal using fabric-safe methods.',
                                                          style: const TextStyle(fontSize: 6.02, fontWeight: FontWeight.w500),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 4.44, top:9.77, bottom: 9.77),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      product.quantity=0;
                                                    });
                                                  },
                                                  child: Icon(Icons.delete, size: 7.33)),
                                              SizedBox(height: 12.03),
                                              Container(
                                                padding: EdgeInsets.only(top: 5.08,left: 8.47, right: 8.47, bottom: 5.08),
                                                width: 54.84,
                                                height: 18.64,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0xFF7ED321), width: 0.42),
                                                  borderRadius: BorderRadius.circular(26.27),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (product.quantity > 0) product.quantity--;
                                                        });
                                                      },
                                                      child: Icon(Icons.remove, size: 7.33),
                                                    ),
                                                    Text('${product.quantity}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 5.93)),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          product.quantity++;
                                                        });
                                                      },
                                                      child: Icon(Icons.add, size: 7.33),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(index != allProducts.length - 1)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 7.33, left: 7.33),
                                      child: Divider(
                                        color: Color(0x1A000000),
                                        thickness: 0.31,
                                        height: 7.64,
                                      ),
                                    ),
                                ],
                              );
                            },
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 26,),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/frames/Frame5.png'),
                  fit: BoxFit.fill
              ),
            ),
            padding: EdgeInsets.only(top:22),
            width: double.infinity,
            child: Column(
              children: [
                Center(child: Text("Delivery Details",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F3C5F),
                      letterSpacing: 0
                  ),
                )),
                SizedBox(height: 26.19,),
                Padding(
                  padding: const EdgeInsets.only(left: 70.81),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Delivery Date',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.black, fontFamily: 'Inter'),
                              children: [TextSpan(text: '*', style: TextStyle(color: Colors.red))],
                            ),
                          ),
                          SizedBox(height: 4.21,),
                          GestureDetector(
                            onTap: _deliverypickDate,
                            child: Container(
                              width: 144.73,
                              height: 29.75,
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(2.86),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _deliverydateController.text.isEmpty ? 'Pick a date' : _deliverydateController.text,
                                    style: TextStyle(
                                      fontSize: 7,
                                      color: _deliverydateController.text.isEmpty ? Colors.grey : Colors.black,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, size: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30.42,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Delivery Time Slot',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.black, fontFamily: 'Inter'),
                              children: [TextSpan(text: '*', style: TextStyle(color: Colors.red))],
                            ),
                          ),
                          SizedBox(height: 4.21,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isDense: true,
                              isExpanded: false,
                              iconStyleData: IconStyleData(
                                icon: Icon(Icons.keyboard_arrow_down, size: 10),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 100,
                                padding: EdgeInsets.symmetric(vertical: 4),
                              ),
                              buttonStyleData: ButtonStyleData(
                                height: 29.75,
                                width: 144.73,
                                padding: EdgeInsets.symmetric(horizontal: 7.7),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: Border.all(color: Colors.grey.shade300, width: 0.37),
                                  borderRadius: BorderRadius.circular(2.86),
                                ),
                              ),
                              hint: Text('Pick a time slot',
                                  style: TextStyle(fontSize: 7, fontFamily: 'Inter')),
                              value: _deliveryselectedTimeSlot,
                              items: deliverytimeSlots.map((slot) {
                                return DropdownMenuItem<String>(
                                  value: slot,
                                  child: Text(slot,
                                      style: TextStyle(fontSize: 7, fontFamily: 'Inter')),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _deliveryselectedTimeSlot = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 41.85,),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 252
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/frames/Frame6.png"),
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft
              ),
            ),
            padding: EdgeInsets.only(top: 12, left: 50, right:42),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Order Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Color(0xFF1F3C5F),
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                SizedBox(height: 11),
                ...selectedProducts.map((product) => Column(
                  children: [
                    Container(
                      width: 348,
                      height: 67,
                      child: Card(
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.11),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 167,
                              height: 57.55,
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.asset(product.imagePaths, width: 49.65, height: 57.17, fit: BoxFit.cover,),
                                    ),
                                    SizedBox(width: 6.89),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
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
                                                      fontSize: 3.76,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF993D20),
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '₹${product.price}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 6.77,
                                                    fontFamily: 'Inter',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5,),
                                            child: Text(
                                              product.description ?? 'Tough stain removal using fabric-safe methods.',
                                              style: const TextStyle(fontSize: 6.02, fontWeight: FontWeight.w500),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 4.44, top:9.77, bottom: 9.77),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          product.quantity=0;
                                        });
                                      },
                                      child: Icon(Icons.delete, size: 7.33)),
                                  SizedBox(height: 12.03),
                                  Container(
                                    padding: EdgeInsets.only(top: 5.08,left: 8.47, right: 8.47, bottom: 5.08),
                                    width: 54.84,
                                    height: 18.64,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF7ED321), width: 0.42),
                                      borderRadius: BorderRadius.circular(26.27),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (product.quantity > 0) product.quantity--;
                                            });
                                          },
                                          child: Icon(Icons.remove, size: 7.33),
                                        ),
                                        Text('${product.quantity}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 5.93)),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              product.quantity++;
                                            });
                                          },
                                          child: Icon(Icons.add, size: 7.33),
                                        ),
                                      ],
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
                )
                ),
                SizedBox(height: 11.54),
                Container(
                  padding: EdgeInsets.only(top: 6.11, left: 7.33, right: 7.33),
                  width: 347,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.11),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 1.22,
                        offset: Offset(0, 1.22)
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      summaryRow("Subtotal", "₹${calculateSubtotal()}"),
                      summaryRow("Discount (-5%)", "-₹${calculateDiscount()}"),
                      summaryRow("Delivery Fee", "₹20"),

                      Container(
                        width: 332.34,
                        padding: const EdgeInsets.only(right: 7.33, left: 7.33),
                        child: Divider(
                          color: Color(0x1A000000),
                          thickness: 0.31,
                          height: 6.11,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "₹${calculateTotal()}",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.33),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 15.33,
                              child: TextField(
                                controller: promo,
                                style: TextStyle(fontSize: 7,),
                                decoration: InputDecoration(
                                  hintText: "Add promo code",
                                  hintStyle: TextStyle(
                                    fontSize: 7,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    letterSpacing: 0
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 4.89, right: 0.67),
                                    child: Icon(Icons.local_offer_outlined, size: 7.33,),
                                  ),
                                  isDense: true,
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 14,
                                    minHeight: 14,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 2.6, horizontal: 2),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.94),
                                    borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.31),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.94),
                                    borderSide: BorderSide(color: Color(0xFF7ED321), width: 0.31),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.67,),
                          Container(
                            width: 36.36,
                            height: 15.33,
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 4.89, vertical: 2.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.53),
                                  side: const BorderSide(color: Colors.black, width: 0.31),
                                ),
                                backgroundColor: const Color(0xFF1F3C5F),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                  fontSize: 7,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  letterSpacing: 0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 80.36,
                        height: 18.33,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1F3C5F),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(top: 4, bottom: 5.17, left: 10.68, right: 5.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.53),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Confirm Pickup",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.67),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 7,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.67,),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Product {
  final String name;
  final String category;
  final String fabric;
  final String description;
  final String price;
  final String imagePaths;
  int quantity;

  Product({
    required this.name,
    required this.category,
    required this.fabric,
    required this.description,
    required this.price,
    required this.imagePaths,
    this.quantity = 0,
  });
}