import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/company.dart';

class CompanyService {
  final String uid;

  CompanyService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<Company> get companyData {
    return companyCollection.document(this.uid).snapshots().map(_companydata);
  }

  Company _companydata(DocumentSnapshot snapshot) {
    Map companyData = snapshot.data;

    return Company(
        address: companyData['address'],
        // booksFrom: ,
        // corporateidentityNumber: ,
        countryName: companyData['country_name'],
        // currencyName: ,
        // currencySymbol: ,
        email: companyData['email'],
        formalName: companyData['formal_name'],
        gstNumber: companyData['gst_number'],
        // guid: ,
        // incometaxNumber: ,
        // interstatestNumber: ,
        // name: ,
        // ownerName: ,
        // phoneNumber: ,
        pincode: companyData['pincode'],
        // startingFrom: ,
        stateName: companyData['state_name']);
  }
}
