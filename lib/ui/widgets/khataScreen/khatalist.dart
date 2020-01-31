import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/widgets/khataScreen/khatatile.dart';


class KhataList extends StatefulWidget {
  @override
  _KhataListState createState() => _KhataListState();
}

class _KhataListState extends State<KhataList> {
  @override
  Widget build(BuildContext context) {
    
    final khataData = Provider.of<List<Khata>>(context);
    final id = DatabaseService().khataCollection.document('PTDQMfuftCgJJiA6UwZOExfawV23').collection('transations').document().documentID;
    
    
    return Container(
      height: 450.0,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true, 
          itemCount: khataData?.length ?? 0,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(khataData[index].toString()),
              onDismissed: (DismissDirection direction) async {
                DatabaseService().deleteKhata(id);
                if (khataData.contains(khataData[index])){
                setState(() {
                  khataData.removeAt(index);
                 
                });
                }
                Scaffold.of(context).showSnackBar(new SnackBar(
                      content: Text("Entry deleted permanently.")
                  ));

              },
                
            background: new Container(color: TassistWarning),
              
              child: KhataTile(khata: khataData[index]));
          },
      ),
    );
  }
}

