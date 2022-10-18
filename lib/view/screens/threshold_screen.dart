import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/label_item.dart';

class ThresholdScreen extends StatefulWidget {
  const ThresholdScreen({Key? key}) : super(key: key);

  @override
  State<ThresholdScreen> createState() => _ThresholdScreenState();
}

class _ThresholdScreenState extends State<ThresholdScreen> {
  bool _isValidate = false;

  TextEditingController _nhietDoController = TextEditingController();
  TextEditingController _doAmController = TextEditingController();
  TextEditingController _doAmDatController = TextEditingController();

  @override
  void dispose() {
    _nhietDoController.dispose();
    _doAmController.dispose();
    _doAmDatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            LabelItem(
              label: "SET THRESHOLD",
              imageUrl: "assets/images/stat.png",
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                controller: _nhietDoController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.deepOrange),
                  ),
                  labelText: 'TEMPERATURE',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                controller: _doAmController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.lightBlue),
                  ),
                  labelText: 'HUMID',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                onEditingComplete: _onSave,
                controller: _doAmDatController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.brown),
                  ),
                  labelText: 'SOIL',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _isValidate == true ? _onSave : null,
                child: Text("SAVE")),
          ],
        ),
      ),
    );
  }

  void _onSave() async {
    // print(
    //     "${_nhietDoController.text == "" ? 0 : _nhietDoController.text}\n${_doAmController.text == "" ? 0 : _doAmController.text}\n${_doAmDatController.text == "" ? 0 : _doAmDatController.text}\n$_isManuel\n");

    DatabaseReference _refThreshold =
        FirebaseDatabase.instance.ref("Threshold");
    await _refThreshold.set({
      "HUM": _doAmController.text == "0" || int.parse(_doAmController.text) == 0
          ? "1"
          : _doAmController.text.toString(),
      "TEMP": _nhietDoController.text == "0" ||
              int.parse(_nhietDoController.text) == 0
          ? "1"
          : _nhietDoController.text.toString(),
      "SOIL": _doAmDatController.text == "0" ||
              int.parse(_doAmDatController.text) == 0
          ? "1"
          : _doAmDatController.text.toString()
    });
    setState(() {
      _nhietDoController.clear();
      _doAmDatController.clear();
      _doAmController.clear();
      _isValidate = false;
    });
  }

  void isValidated() {
    setState(() {
      _isValidate = _nhietDoController.text.isNotEmpty &&
          _doAmController.text.isNotEmpty &&
          _doAmDatController.text.isNotEmpty;
    });
  }
}
