import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatelessWidget{
  RegisterScreen({super.key});

  bool isChecked = true;
  String phoneNumb ='';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leading: Padding(
           padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const ShapeDecoration(shape: CircleBorder(
            ),color: Colors.black54
          ),
          child: IconButton(onPressed: () => Navigator.of(context).pop(),icon:const Icon(Icons.arrow_back),),),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center,
            child: Image.asset(
              "assets/image/logo.png",
              width: 250,
              height: 130,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text("Đăng Ký Số Điện Thoại Của Bạn",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            child:  const  Text("Thêm số điện thoại của bạn. Chúng tôi sẽ gửi cho bạn mã xác thực để biết đó chính là bạn",textAlign: TextAlign.center,style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: TextFormField(
                  onChanged: (text) {
                    phoneNumb = text;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    border: OutlineInputBorder(),
                    hintText: ("Nhập số điện thoại"),
                    prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 14,horizontal: 14),
                    child: Text("  (+84)  "),),
                    suffixIcon: Visibility(
                      visible: false,
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 14,horizontal: 14),
                      child: InkWell(child: Text(" RESEND ",style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),),),),
                    )
                    //errorText: (""),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) => (value == null || value.isEmpty) ?  'Vui lòng nhập đúng số điện thoại' : null
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                    minimumSize:
                    const Size.fromHeight(50), // NEW
                  ),
                  onPressed: isChecked ?  () {
                    if(_formKey.currentState!.validate()){
                      print("Register Success");
                    }
                    else {
                    }
                  } : null,
                  child: const Text("SEND OTP"))),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                textTrim("By providing my phone number, I here by agree and accept the ", Colors.grey),
                textTrim("Terms of Service", Colors.red),
                textTrim(" and ", Colors.grey),
                textTrim("Privacy Policy", Colors.red),
                textTrim(" in use of the TrenBoongConcept", Colors.grey)
              ],
            ),
          )


        ],

      ),),

    );
  }
  Widget textTrim(String text, Color color) => Text(text,textAlign: TextAlign.center,style: TextStyle(
      color:color,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    decoration: color == Colors.red ? TextDecoration.underline : null
  ),);

}