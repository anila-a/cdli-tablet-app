import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpModel extends StatefulWidget {
  @override
  _HelpModelState createState() => _HelpModelState();
}

class _HelpModelState extends State<HelpModel> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String email;
  String feedback;

  Color buttonColor = const Color.fromRGBO(48, 48, 48, 1); // 32, or 7

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Text('HELP AND FEEDBACK', style: TextStyle(color: Colors.grey, fontSize: 17, fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w400,)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.help_outline, color: Colors.white, size: 22,),
                    SizedBox(width: 10,),
                    Text('Send feedback', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w400,)),
                  ],
                ),
              ),
              Divider(color: Colors.white, thickness: 0.28,),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('You can help improve cdli tablet app by giving '
                            'us feedback about any issues you are having.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.w400,
                              )),
                        ),
                  ],),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    labelText: 'Email address',
                                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'NotoSansJP',
                                      fontWeight: FontWeight.w400,),
                                    border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email address is required.';
                                }
                              },
                              onSaved: (value) => email = value,
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 17.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: TextStyle(color: Colors.white),
                                     decoration: InputDecoration(
                                       disabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey)
                                       ),
                                       enabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color: Colors.grey)
                                       ),
                                       labelText: 'Feedback',
                                       labelStyle: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'NotoSansJP',
                                         fontWeight: FontWeight.w400,),
                                       border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Feedback cannot be empty.';
                                      }
                                    },
                                    onSaved: (value) => feedback = value,
                                  ),
                                ),
                        ],),),),
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 330.0,
                                height: 50.0,
                                child: RaisedButton(
                                  color: buttonColor,
                                  onPressed: submitFeedback,
                                  child: Text('Submit', style: TextStyle(
                                    color: Colors.white, fontSize: 15, fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.w400,), textAlign: TextAlign.center),
                                ),
                              )
                            ],
                          ),
                        ),
                ],)),),
              ),
            ]),
      ),
    );
  }
  
  void submitFeedback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db.collection('cdli-tablet').add({'email': '$email', 'feedback': '$feedback'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }
}
