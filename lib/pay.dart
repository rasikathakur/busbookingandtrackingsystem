import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:bustracking/ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key? key}): super(key: key);
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {

  var _razorpay = Razorpay();
  var amountController;
  var paymentStatus = "Process";
  var responsestatatus;
  var pricehere;
  final userRepo = Get.put(UserRepository());
  late final currentUserEmail;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Done");
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketScreen()));
    setState(() {
      responsestatatus = 200;
    });
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
    print(paymentStatus);
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      responsestatatus = 100;
    });
    print("Payment Failed");
    userRepo.deleteRecentPayment(currentUserEmail!);
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      responsestatatus = 300;
    });
    userRepo.deleteRecentPayment(currentUserEmail!);
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    currentUserEmail = currentUser?.email;
    List<Object?> argument = ModalRoute.of(context)!.settings.arguments as List<Object?>;
    pricehere = argument[0];
    amountController = new TextEditingController(text: '${pricehere}');
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "BOTO"
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    hintText: "Enter Amount to be Paid...",
                  ),
                ),
              ),
              CupertinoButton(
                color: Colors.deepPurpleAccent,
                  child: Text(
                "Pay Amount",
              ),
                  onPressed:(){
                    var options = {
                      'key': 'rzp_test_PFhOGg8NwXC3XS',
                      'amount': (int.parse(amountController.text)*100).toString(),
                      'name': 'BOTO',
                      'description': 'Bus Booking and Tracking System',
                      'prefill': {
                       'contact': '8010685987',
                       'email': 'rasikathakur303@gmail.com'
                      }
                    };
                  _razorpay.open(options);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {
        if (responsestatatus==200) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketScreen(
          )));
        }
        else{
          //userRepo.deleteRecentPayment(currentUserEmail!);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PayScreen()));
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
