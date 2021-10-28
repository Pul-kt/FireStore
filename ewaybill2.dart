double totalquantity = 0, totalamount = 0;
    List<Items> items1 = [];
    int ewaybillno;
    Future<Null> _tocanceWaylBill() async {
      await db
          .collection("userData")
          .doc(widget.uid)
          .collection("Invoice")
          .doc(ewaybillController.text.toString())
          .get()
          .then((valuee) {
        setState(() {
          invoiceno1.text = valuee.data()['invoiceno'] == null
              ? ''
              : valuee.data()['invoiceno'];

          bname.text =
              valuee.data()['bname'] == null ? '' : valuee.data()['bname'];
          bphone.text =
              valuee.data()['bphone'] == null ? '' : valuee.data()['bphone'];
          bcity.text =
              valuee.data()['bcity'] == null ? '' : valuee.data()['bcity'];
          bstate.text =
              valuee.data()['bstate'] == null ? '' : valuee.data()['bstate'];
          scity.text =
              valuee.data()['scity;'] == null ? '' : valuee.data()['scity;'];
          sstate.text =
              valuee.data()['sstate'] == null ? '' : valuee.data()['sstate'];
          bpin.text =
              valuee.data()['bpin'] == null ? '' : valuee.data()['bpin'];
          bgstn.text =
              valuee.data()['bgstn'] == null ? '' : valuee.data()['bgstn'];
          sname.text =
              valuee.data()['sname'] == null ? '' : valuee.data()['sname'];
          sphone.text =
              valuee.data()['sphone'] == null ? '' : valuee.data()['sphone'];
          transportername.text = valuee.data()['transportername'] == null
              ? ''
              : valuee.data()['transportername'];
          spin.text =
              valuee.data()['spin'] == null ? '' : valuee.data()['spin'];
          transporterid.text = valuee.data()['transporterid'] == null
              ? ''
              : valuee.data()['transporterid'];
          tracnsportdocno.text = valuee.data()['transporterdocno'] == null
              ? ''
              : valuee.data()['transporterdocno'];
          tdate.text = valuee.data()['tdate'];
          sgstn.text =
              valuee.data()['sgstn'] == null ? '' : valuee.data()['sgstn'];
          timestamp = (valuee.data()['sdate']) as Timestamp;
          sdate = timestamp.toDate();

          vehiclemode.text = valuee.data()['vehiclemode'] == null
              ? ''
              : valuee.data()['vehiclemode'];
          vehicleno.text = valuee.data()['vehicleno'] == null
              ? ''
              : valuee.data()['vehicleno'];
          l = List.castFrom(valuee.data()['listOfProducts']);
        });
      });

      l.forEach((element) {
        setState(() {
          totalquantity =
              totalquantity + double.parse(element['quantity'].toString());
          totalamount =
              totalamount + double.parse(element['totalamount'].toString());
        });
      });
      db
          .collection("userData")
          .doc(widget.uid)
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

      List items = [];

      l.forEach((element) {
        setState(() {
          items.add({
            "product_name": element['productName'],
            "product_description": element['productCode'],
            "hsn_code": '1001', // element['hsncode'],
            "unit_of_product": 'BOX', //element['unit'],
            "cgst_rate": 9,
            "sgst_rate": 9,
            "igst_rate": 0,
            "cess_rate": 0,
            "quantity": 9, //int.tryParse(element['quantity']),
            "cessNonAdvol": 0,
            "taxable_amount": 9, // int.tryParse(element['totalamount'])*/
          });
        });
      });
      try {
        (int.parse(spin.text));
      } on FormatException {
        Fluttertoast.showToast(msg: 'Invalid Pincode', timeInSecForIosWeb: 4);
      }
      try {
        final response = await http.post(
          Uri.parse('https://clientbasic.mastersindia.co/ewayBillsGenerate'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<dynamic, dynamic>{
            "access_token": responsedecode.access_token,
            "userGstin": "05AAABB0639G1Z8",
            "supply_type": "outward",
            "sub_supply_type": "Others",
            "sub_supply_description": "sales from other country",
            "document_type": "tax invoice",
            "document_number": "127-308",
            "document_date": "10/05/2018",
            "gstin_of_consignor": "05AAABB0639G1Z8 ",
            "legal_name_of_consignor": "welton",
            "address1_of_consignor": "2ND CROSS NO 59 19 A",
            "address2_of_consignor": "GROUND FLOOR OSBORNE ROAD",
            "place_of_consignor": "Dehradun",
            "pincode_of_consignor": 248001,
            "state_of_consignor": "UTTARAKHAND",
            "actual_from_state_name": "UTTARAKHAND",
            "gstin_of_consignee": "05AAABC0181E1ZE ",
            "legal_name_of_consignee": "sthuthya",
            "address1_of_consignee": "Shree Nilaya",
            "address2_of_consignee": "Dasarahosahalli",
            "place_of_consignee": "Beml Nagar",
            "pincode_of_consignee": 263001,
            "state_of_supply": "UTTARAKHAND ",
            "actual_to_state_name": "UTTARAKHAND",
            "transaction_type": 1,
            "other_value": -0.06,
            "total_invoice_value": 2.06,
            "taxable_amount": 2,
            "cgst_amount": 0.03,
            "sgst_amount": 0.03,
            "igst_amount": 0,
            "cess_amount": 0,
            "cess_nonadvol_value": 0,
            "transporter_id": "05AAABB0639G1Z8",
            "transporter_name": "",
            "transporter_document_number": "",
            "transporter_document_date": "",
            "transportation_mode": "road",
            "transportation_distance": "656",
            "vehicle_number": "PVC1234",
            "vehicle_type": "Regular",
            "generate_status": 1,
            "data_source": "erp",
            "user_ref": "1232435466sdsf234",
            "location_code": "XYZ",
            "eway_bill_status": "ABC",
            "auto_print": "Y",
            "email": "mayanksharma@mastersindia.co",
            "itemList": [
              {
                "product_name": "CRCA",
                "product_description": "ABC",
                "hsn_code": "1001",
                "unit_of_product": "BOX",
                "cgst_rate": 9,
                "sgst_rate": 9,
                "igst_rate": 0,
                "cess_rate": 0,
                "quantity": 1,
                "cessNonAdvol": 0,
                "taxable_amount": 49
              },
              {
                "quantity": 1,
                "cessNonAdvol": 0,
                "product_name": "CRCA",
                "product_description": "AVC",
                "hsn_code": "1001",
                "unit_of_product": "BOX",
                "cgst_rate": 9,
                "sgst_rate": 9,
                "igst_rate": 0,
                "cess_rate": 0,
                "taxable_amount": 1
              },
              {
                "quantity": 1.0,
                "cessNonAdvol": 0,
                "product_name": "XYZ",
                "product_description": "ABC",
                "hsn_code": "1001",
                "unit_of_product": "KGS",
                "cgst_rate": 2.5,
                "sgst_rate": 2.5,
                "igst_rate": 0,
                "cess_rate": 0,
                "taxable_amount": 200
              },
              {
                "quantity": 200,
                "cessNonAdvol": 0,
                "product_name": "ABC",
                "product_description": "ASD",
                "hsn_code": "1001",
                "unit_of_product": "NOS",
                "cgst_rate": 2.5,
                "sgst_rate": 2.5,
                "igst_rate": 0,
                "cess_rate": 0,
                "taxable_amount": 20000.0
              }
            ]
          }),
        );
        print(response.statusCode);
