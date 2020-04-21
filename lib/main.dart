import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SIform(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIform> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  final _minimumpadding = 5.0;
  var displayText = '';
  var _currentitemselected;

  @override
  void initState() {
    super.initState();
    _currentitemselected = _currencies[0];
  }

  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding: EdgeInsets.all(_minimumpadding * 2),
                child: ListView(children: <Widget>[
                  getImageAsset(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: principal,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          labelStyle: textStyle,
                          errorStyle:
                              TextStyle(fontSize: 15.0, color: Colors.yellow),
                          hintText: 'Enter principal amount e.g. 12000',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter the rate of interest!';
                        }
                      },
                      style: textStyle,
                      controller: roi,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Rate of interest',
                          labelStyle: textStyle,
                          hintText: 'Enter interest in percent e.g. 8',
                          errorStyle:
                              TextStyle(fontSize: 15.0, color: Colors.yellow),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minimumpadding, bottom: _minimumpadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              style: textStyle,
                              controller: time,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter time period';
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Term',
                                  hintText: 'Time in years',
                                  errorStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.yellow),
                                  labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                          ),
                          Container(
                            width: _minimumpadding * 5,
                          ),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String Value) {
                              return DropdownMenuItem<String>(
                                value: Value,
                                child: Text(Value),
                              );
                            }).toList(),
                            value: _currentitemselected,
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentitemselected = newValueSelected;
                              });
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minimumpadding, bottom: _minimumpadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text(
                                "Calculate",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formkey.currentState.validate()) {
                                    this.displayText = _calculateTotalReturns();
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Reset",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              },
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(_minimumpadding * 2),
                    child: Text(
                      this.displayText,
                      style: textStyle,
                    ),
                  )
                ]))));
  }

  String _calculateTotalReturns() {
    double p = double.parse(principal.text);
    double r = double.parse(roi.text);
    double t = double.parse(time.text);
    double amt = p + ((p * r * t) / 100);
    String res =
        'After $t years, your investment will worth $amt $_currentitemselected';
    return res;
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumpadding * 10),
    );
  }

  void _reset() {
    principal.text = '';
    roi.text = '';
    time.text = '';
    displayText = '';
    _currentitemselected = _currencies[0];
  }
}
