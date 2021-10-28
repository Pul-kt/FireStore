import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digitalbillbook/models/invoicemodel.dart';
import 'package:digitalbillbook/models/items.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Access_token {
// ignore: non_constant_identifier_names
  final String access_token;
// ignore: non_constant_identifier_names
  final expires_in;
// ignore: non_constant_identifier_names
  final String token_type;

  // ignore: non_constant_identifier_names
  Access_token({this.access_token, this.expires_in, this.token_type});

  factory Access_token.fromJson(Map<String, dynamic> json) {
    return Access_token(
        access_token: json['access_token'],
        expires_in: json['expires_in'],
        token_type: json['token_type']);
  }
}

class GetUrl {
// ignore: non_constant_identifier_names
  final String url;

  // ignore: non_constant_identifier_names
  GetUrl({this.url});

  factory GetUrl.fromJson(Map<String, dynamic> json) {
    return GetUrl(url: json['results']['message']['url']);
  }
}

class GetEwayBIllno {
// ignore: non_constant_identifier_names
  final int ewaybillno;

  // ignore: non_constant_identifier_names
  GetEwayBIllno({this.ewaybillno});

  factory GetEwayBIllno.fromJson(Map<String, dynamic> json) {
    return GetEwayBIllno(ewaybillno: json['results']['message']["ewayBillNo"]);
  }
}

class Ewaybill1 extends StatefulWidget {
  final String uid;
  Ewaybill1(this.uid);

  @override
  _Ewaybill1State createState() => _Ewaybill1State();
}

class Accesstoken {
  final String accesstoken;
  final String expiresin;
  final String tokentype;
  Accesstoken({this.accesstoken, this.expiresin, this.tokentype});

  factory Accesstoken.fromJson(Map<String, dynamic> json) {
    return Accesstoken(
        accesstoken: json["access_token"],
        expiresin: json["expires_in"],
        tokentype: json["token_type"]);
  }
}

Access_token responsedecode;

class _Ewaybill1State extends State<Ewaybill1> {
  final ewaybillController = TextEditingController();
  Future<Null> createAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('https://clientbasic.mastersindia.co/oauth/access_token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<dynamic, dynamic>{
          "username": "testeway@mastersindia.co",
          "password": "!@#Demo!@#123",
          "client_id": "fIXefFyxGNfDWOcCWnj",
          "client_secret": "QFd6dZvCGqckabKxTapfZgJc",
          "grant_type": "password"
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        responsedecode = Access_token.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    createAccessToken();

    super.initState();
  }

  Future<Null> createFile(String url1, String fileName) async {
    try {
      /// setting filename
      final filename = fileName;

      /// getting application doc directory's path in dir variable
      String dir = (await getApplicationDocumentsDirectory()).path;

      /// if `filename` File exists in local system then return that file.
      /// This is the fastest among all.
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      ///if file not present in local system then fetch it from server
      String url = url1 + '.pdf';

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      /// returning file.
    }

    /// on catching Exception return null
    catch (err) {
      print(err);
      return null;
    }
  }

  Future<Accesstoken> _accestoken;
  @override
  Widget build(BuildContext context) {
    String _businessNameController;
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final gstNumberController = TextEditingController();
    final businesAddressController = TextEditingController();
    final bankNameController = TextEditingController();
    final ifscCodeController = TextEditingController();
    final accountNumberController = TextEditingController();
    final branchNameController = TextEditingController();
    final invoiceno1 = TextEditingController();
    final bname = TextEditingController();
    final bphone = TextEditingController();
    final bgstn = TextEditingController();
    final bcity = TextEditingController();
    final bstate = TextEditingController();
    final bcountry = TextEditingController();
    final bpin = TextEditingController();
    final sname = TextEditingController();
    final sphone = TextEditingController();
    final sgstn = TextEditingController();
    DateTime sdate;
    final scity = TextEditingController();
    final sstate = TextEditingController();
    final scountry = TextEditingController();
    final spin = TextEditingController();
    final productCode = TextEditingController();
    final productName = TextEditingController();
    final hsncode = TextEditingController();
    final taxrate = TextEditingController();
    final quantity = TextEditingController();
    final unit = TextEditingController();
    final sellingrate = TextEditingController();
    final taxamount = TextEditingController();
    final transporterid = TextEditingController();
    final transportername = TextEditingController();
    final tracnsportdocno = TextEditingController();
    final tdate = TextEditingController();
    final vehiclemode = TextEditingController();
    final vehicleno = TextEditingController();
    final from = TextEditingController();
    final invoicedetails = new InvoiceModel(
        '',
        '',
        ' ',
        ' ',
        ' ',
        DateTime.now(),
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        DateTime.now(),
        ' ',
        ' ',
        ' ',
        ' ',
        null,
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        ' ',
        null,
        null,
        null,
        null,
        null);

    List<Map<String, dynamic>> l = [];

    final db = FirebaseFirestore.instance;
    Future<Null> _getBusinessDetails(String uid) async {
      await db
          .collection("userData")
          .doc(uid)
          .collection("BusinessInfo")
          .doc('businessName')
          .get()
          .then((valuee) {
        setState(() {
          bankNameController.text = valuee.data()['bankName'] == null
              ? ''
              : valuee.data()['bankName'];
          accountNumberController.text = valuee.data()['accountNumber'] == null
              ? ''
              : valuee.data()['accountNumber'];
          ifscCodeController.text = valuee.data()['ifscCode'] == null
              ? ''
              : valuee.data()['ifscCode'];

          branchNameController.text = valuee.data()['branchName'] == null
              ? ''
              : valuee.data()['branchName'];
          _businessNameController = valuee.data()['businessName'] == null
              ? ''
              : valuee.data()['businessName'];
          businesAddressController.text =
              valuee.data()['businessAddress'] == null
                  ? ''
                  : valuee.data()['businessAddress'];
          gstNumberController.text = valuee.data()['gstNumber'] == null
              ? ''
              : valuee.data()['gstNumber'];
          emailController.text =
              valuee.data()['email'] == null ? '' : valuee.data()['email'];
          phoneController.text =
              valuee.data()['phone'] == null ? '' : valuee.data()['phone'];
        });
      });
    }

    Timestamp timestamp;
    Future<Null> downloadFile(String url, String fileName, String dir) async {
      HttpClient httpClient = new HttpClient();
      File file;
      String filePath = '';
      String myUrl = '';
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      try {
        myUrl = url + '.pdf';
        var request = await httpClient.getUrl(Uri.parse(myUrl));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          filePath = '$appDocPath/$fileName.pdf';
          file = File(filePath);
          await file.writeAsBytes(bytes);
        } else
          filePath = 'Error code: ' + response.statusCode.toString();
      } catch (ex) {
        filePath = 'Can not fetch url';
      }
      print(filePath);
    }
