import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? result;

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Modal Example'),
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       // Wait for the result from the dialog
      //       final selectedItem = await showDialog(
      //         context: context,
      //         barrierDismissible: true, // Allows dismissing by tapping outside
      //         builder: (BuildContext context) {
      //           return Stack(
      //             alignment: Alignment.bottomCenter,
      //             children: [
      //               Wrap(
      //                 children: [
      //                   Material(
      //                     child: Container(
      //                       color: Colors.white,
      //                       width: double.infinity,
      //                       height: 200,
      //                       child: SingleChildScrollView(
      //                         child: Column(
      //                           children: List.generate(
      //                             30,
      //                             (index) => ListTile(
      //                               title: InkWell(
      //                                 onTap: () {
      //                                   // Pass data back when an item is tapped
      //                                   Navigator.pop(
      //                                       context, 'Item ${index + 1}');
      //                                 },
      //                                 child: Text('Item ${index + 1}'),
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           );
      //         },
      //       );

      //       // Update the result and rebuild the UI
      //       if (selectedItem != null) {
      //         setState(() {
      //           result = selectedItem;
      //         });
      //       }
      //     },
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Text('Show Custom Modal'),
      //         if (result != null) Text(result!), // Display result if available
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

void getData() {
  final dio = Dio(
    BaseOptions(
      headers: {
        'content-type': 'application/json',
        'Accept-Language': 'ar',
        'applicationName': 'CASH',
        'applicationPassword': 'ZFZyqUpqeO9TMhXg4R/9qs0Igwg=',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJjaGFubmVsIjoiQ0FTSCIsImN1c3RvbWVyQ29kZSI6bnVsbCwiZXhwIjozMzIzODgyMTg5MSwiaWF0IjoxNjgxMjIxODkxLCJzZWxlY3RlZERpYWwiOiIxMTQwMjgyOTQ2IiwiZGlhbCI6IjExNDAyODI5NDYiLCJ1c2VybmFtZSI6IjExNDAyODI5NDYsbXljYXNodWRpZCJ9.ELmbBvjGA_Kzmd8dAOdPCBuGH3AMQKM5odNQmxr2C93b9oXTnw_nhNPjxTDig-B7wt7MOWNRmSlQ347SGOL2bg',
        'Platform': 'ANDROID',
        'APP-Version': '9.1.0',
        'app': 'Cash',
      },
    ),
  );

  dio.post(
    'https://mab.etisalat.com.eg:11003/Saytar/rest/etisalatAndpay/service/CHECK_BALANCE',
    data: {
      'type': 'PaymentRequest',
      'ClientID': 1234567,
      'ClientLanguageID': 1,
      'MSISDN': 1140282946,
      'Password': 164379,
      'Username': 1140282946,
      'getBalanceDetails': 1
    },
  ).then((value) {
    print(value);
    print(value.statusCode);
  });
}
