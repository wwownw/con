import 'package:flutter/material.dart';

class SelectAffWidget extends StatefulWidget {
  const SelectAffWidget({Key? key}) : super(key: key);

  @override
  State<SelectAffWidget> createState() => _SelectAffWidgetState();
}

class _SelectAffWidgetState extends State<SelectAffWidget> {
  final List<String> region = ['서울', '충청남도'];
  final List<String> affA = ['강남', '강북'];
  final List<String> affB = ['보령', '천안'];

  String? selectRegion;
  String? selectAff;
  List<String> affiliation = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            isExpanded: true,
            hint: const Text('지역'),
            borderRadius: BorderRadius.circular(20),
            value: selectRegion,
            items: region.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (val) {
              selectAff = null;
              affiliation = val == '서울' ? affA : affB;
              setState(() {
                selectRegion = val!;
              });
            },
          ),
          DropdownButton<String>(
            isExpanded: true,
            hint: const Text('소속'),
            borderRadius: BorderRadius.circular(20),
            value: selectAff,
            items: affiliation.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectAff = val!;
                myAffiliation = selectAff;
              });
            },
          ),
        ],
      ),
    );
  }
}

String? myAffiliation;
