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

  Future updateCompanyRecord(
      {String upiAddress,
      String companyName,
      String phoneNumber,
      String gstNumber,
      String registeredAddress}) async {
    return await companyCollection.document(this.uid).setData({
      'upi_address': upiAddress,
      'name': companyName,
      'phonenumber': phoneNumber,
      'gstnumber': gstNumber,
      'address': registeredAddress,
    }, merge: true);
  }

  Company _companydata(DocumentSnapshot snapshot) {
    Map companyData = snapshot.data;

    if (companyData != null) {
      return Company(
        address: companyData['address'] ?? '',
        // booksFrom: ,
        // corporateidentityNumber: ,
        countryName: companyData['countryname'] ?? '',
        // currencyName: ,
        // currencySymbol: ,
        email: companyData['email'] ?? '',
        formalName: companyData['basicompanyformalname'] ?? '',
        gstNumber: companyData['gstnumber'] ?? '',
        // guid: ,
        // incometaxNumber: ,
        // interstatestNumber: ,
        // name: ,
        // ownerName: ,
        // phoneNumber: ,
        pincode: companyData['pincode'] ?? '',
        // startingFrom: ,
        stateName: companyData['statename'] ?? '',
        hasLogo: companyData['restat_has_logo'] ?? '',
        lastEntryDate: companyData['lastentrydate'] ?? '',
        lastSyncedAt: companyData['last_synced_at'].toDate() ?? '',
      );
    } else {
      return Company(
        address: '',
        countryName: '',
        email: '',
        formalName: '',
        gstNumber: '',
        pincode: '',
        stateName: '',
        hasLogo: '',
      );
    }
  }
}
