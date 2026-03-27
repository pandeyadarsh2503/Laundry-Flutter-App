import 'package:flutter/material.dart';
import 'package:laundry/signup.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
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
  var passText = TextEditingController();
  bool _obscureText = true;
  bool rememberMe = false;
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
          child: Padding(padding: const EdgeInsets.only(left: 25, top: 111, right: 25),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login", style: TextStyle(
                    color:Color(0xFF1F3C5F),
                    fontSize: 42.74,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.85,
                    fontFamily: 'Inter')),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Don't have an account?", style: TextStyle(
                        fontSize: 16.03,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.16,
                        height: 1.4,
                        fontFamily: 'Inter')),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> Signup()),
                          );
                        },
                        child: Text(" Sign Up", style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.16,
                          height: 1.4,
                          color: Color(0xFF3B68BF)
                        ),),
                      )
                    ],
                  ),
                  SizedBox(height: 36,),
                  Text("E-mail", style: TextStyle(
                    fontSize: 16.03,
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w600,
                    // letterSpacing: -0.85,
                    height: 1.6,
                  )),
                  SizedBox(height: 6,),
                  TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                    hintText: 'Enter Email-Id',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.36),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.36),
                      borderSide: BorderSide(color: Color(0xFF1F3C5F), width: 1.2),
                    ),
                  ),),
                  SizedBox(height: 21,),
                  Text("Password", style: TextStyle(
                    fontSize: 16.03,
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w600,
                    // letterSpacing: -0.85,
                    height: 1.6,
                  )),
                  SizedBox(height: 6,),
                  TextField(
                    controller: passText,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.36),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.36),
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
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: rememberMe, onChanged: (val){
                            setState(()=> rememberMe=val!);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(width: 2),
                          splashRadius: 0,
                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Color(0xFF1F3C5F); // Checked fill color
                              }
                              return Colors.transparent; // Unchecked background
                            }),
                            ),
                          Text("Remember Me",
                            style: TextStyle(
                                fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 16.03, letterSpacing: -0.16))
                        ],
                      ),
                      Text("Forgot Password ?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.03,
                          color: Color(0xFF3B68BF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60,),
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
                          child: Text("Log In",
                              style: TextStyle(
                                  fontSize: 16.99,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  SizedBox(height: 55,),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1,color: Color(0xFF444444))),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Or",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.56,
                              color: Color(0xFF444444))),
                      ),
                      Expanded(child: Divider(thickness: 1,color: Color(0xFF444444)))
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
                  SizedBox(height: 50,)
            ],
            )
        ),
      ),
    )
    );
  }
}
