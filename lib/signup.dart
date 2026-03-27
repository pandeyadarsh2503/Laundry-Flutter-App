import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Widget buildSocialButton({
    required String iconPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0x0DFFFFFF),
          elevation: 0,
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 21.84,
              height: 21.84,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.99,
                  letterSpacing: -0.16
              ),
            ),
          ],
        ),
      ),
    );
  }
  var emailText = TextEditingController();
  var name = TextEditingController();
  var passText = TextEditingController();
  var phone = TextEditingController();
  String phoneLengthText = 'Phone number length: 0';
  bool hasUpperCase = false;
  bool hasDigits = false;
  bool hasSpecial = false;
  bool hasMinLength = false;

  String password = '';
  void checkPassword(String value) {
    password = value;
    setState(() {
      hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      hasDigits = value.contains(RegExp(r'[0-9]'));
      hasSpecial = value.contains(RegExp(r'[!@#\$&*~]'));
      hasMinLength = value.length >= 8;
    });
  }

  bool _obscureText = true;
  bool rememberMe = false;

  Widget buildPasswordGuidelines() {
    List<String> rules = [];
    if (!hasUpperCase) rules.add("At least one uppercase letter");
    if (!hasDigits) rules.add("At least one digit");
    if (!hasSpecial) rules.add(r'At least one special character (!@#\$&*~)');
    if (!hasMinLength) rules.add("Minimum 8 characters");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rules
          .map(
            (rule) => Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 16),
              const SizedBox(width: 6),
              Text(rule, style: const TextStyle(color: Colors.red, fontSize: 13)),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors:[
                Color(0xFFA9E26A),
                Color(0xFFC8C8C8),
                Color(0xFF1F3C5F),
              ],
              stops: [0.0, 0.5, 1.0],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.only(left: 27, top: 28, right: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },icon: Image.asset('assets/icons/vector.png',width: 16.48,height: 9.42,),padding: EdgeInsets.only(top: 28.26, right: 23),),
                    SizedBox(height: 15,),
                    Text("Sign Up", style: TextStyle(
                        color:Color(0xFF1F3C5F),
                        fontSize: 42.74,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.85,
                        fontFamily: 'Inter')),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text("Create an account to continue!", style: TextStyle(
                            fontSize: 14.13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.16,
                            height: 1.4,
                            fontFamily: 'Inter')),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Text("Full Name", style: TextStyle(
                      fontSize: 16.03,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w600,
                      // letterSpacing: -0.85,
                      height: 1.6,
                    )),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16.48),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.31),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 0.31),
                        ),
                      ),),
                    SizedBox(height: 18,),
                    Text("E-mail", style: TextStyle(
                      fontSize: 16.03,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w600,
                      // letterSpacing: -0.85,
                      height: 1.6,
                    )),
                    TextField(
                      controller: emailText,
                      decoration: InputDecoration(
                        hintText: 'Enter Email-Id',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16.48),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                        ),
                      ),),
                    SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone Number", style: TextStyle(
                          fontSize: 16.03,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w600,
                          // letterSpacing: -0.85,
                          height: 1.6,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '${phone.text.length}/10',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IntlPhoneField(
                      controller: phone,
                      decoration: InputDecoration(
                        hintText: '(454) 726-0592',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16.48),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.77),
                          borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                        ),
                      ),
                    initialCountryCode: 'IN',
                    flagsButtonPadding: EdgeInsets.symmetric(horizontal: 10),
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      size: 24,
                    ),
                    dropdownIconPosition: IconPosition.trailing,
                    disableLengthCheck: true,
                    onChanged:(phone){
                        setState(() {
                          phoneLengthText = 'Phone number length: ${phone.number.length}';
                        });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],),
                    SizedBox(height: 18,),
                    Text("Set Password", style: TextStyle(
                      fontSize: 16.03,
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w600,
                      // letterSpacing: -0.85,
                      height: 1.6,
                    )),
                    TextField(
                      onChanged: checkPassword,
                      controller: passText,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          hintText: 'Enter new password',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16.48),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.77),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.77),
                            borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility, color: Colors.grey),
                            onPressed: (){
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                      ),),
                    if (password.isNotEmpty && !(hasUpperCase && hasDigits && hasSpecial && hasMinLength)) ...[
                      SizedBox(height: 10),
                      Text("Your password must contain:",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      if (!hasUpperCase)
                        Text("• At least one uppercase letter", style: TextStyle(color: Colors.red)),
                      if (!hasDigits)
                        Text("• At least one number", style: TextStyle(color: Colors.red)),
                      if (!hasSpecial)
                        Text(r"• At least one special character (!@#\$&*~)", style: TextStyle(color: Colors.red)),
                      if (!hasMinLength)
                        Text("• Minimum 8 characters", style: TextStyle(color: Colors.red)),
                      SizedBox(height: 12,)
                    ] else ...[
                      SizedBox(height: 60,)
                    ],
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(
                              context,
                              'main_page',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1F3C5F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )
                          ),
                          child: Text("Register",
                              style: TextStyle(
                                  fontSize: 16.99,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.16,
                            height: 1.4,
                            fontFamily: 'Inter')),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> MyLogin()),
                            );
                          },
                          child: Text(" Login", style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.16,
                              height: 1.4,
                              color: Color(0xFF0050EC)
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 22,),
                    buildSocialButton(
                        iconPath: 'assets/icons/google.png',
                        text: "Continue With Google",
                        onTap: (){}
                    ),
                    SizedBox(height: 15,),
                    buildSocialButton(
                        iconPath: 'assets/icons/facebook.png',
                        text: "Continue with Facebook",
                        onTap: (){}
                    ),
                    SizedBox(height: 40,)
                  ],
                )
            ),
          ),
        )
    );
  }
}

