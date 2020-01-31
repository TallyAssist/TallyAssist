import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/ui/widgets/khataScreen/khatatile.dart';


class KhataList extends StatefulWidget {
  @override
  _KhataListState createState() => _KhataListState();
}

class _KhataListState extends State<KhataList> {
  @override
  Widget build(BuildContext context) {
    
    final khataData = Provider.of<List<Khata>>(context);
    
    
    return Container(
      height: 500.0,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true, 
          itemCount: khataData?.length ?? 0,
          itemBuilder: (context, index) {
            return KhataTile(khata: khataData[index]);
          },
      ),
    );
  }
}
