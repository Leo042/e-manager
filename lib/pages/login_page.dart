import 'package:spot_manager/models/models.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/ui_widgets/alertDialog.dart';
import 'package:spot_manager/ui_widgets/wave_clip_widget.dart';

class Login extends StatefulWidget {
  final Function changeTheme;
  final bool signUp;

  Login({this.changeTheme, this.signUp});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _infoData = {
    'email': null,
    'password': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WaveClip(),
            Form(
              key: formKey,
              child: ScopedModelDescendant<Models>(
                builder: (context, child, Models model) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      // widget.signUp == true
                      //     ? SignUp(
                      //     setType: setType,
                      //     setFName: setFName,
                      //     setNumber: setNumber,
                      //     setUserName: setUserName)
                      //     : Container(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _infoData['email'] = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value.length == 0 ? 'enter email' : null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _infoData['password'] = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) =>
                                value.length == 0 ? 'enter password' : null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: model.isLoading == true
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                )
                              : TextButton(
                                  child: Text(
                                    widget.signUp == true ? 'SignUp' : 'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  onPressed: () => _signIn(model)),
                        ),
                      ),
                      SizedBox(height: 20),
                      widget.signUp == true
                          ? Container()
                          : Center(
                              child: TextButton(
                                child: Text(
                                  'FORGOT PASSWORD ?',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {},
                              ),
                            ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account ?"),
                          TextButton(
                              child: Text(
                                  widget.signUp == true ? 'Sign In' : 'Sign Up',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => widget.signUp ==
                                              true
                                          ? Login(
                                              changeTheme: widget.changeTheme)
                                          : Login(
                                              signUp: true,
                                              changeTheme: widget.changeTheme,
                                            ),
                                    ));
                              }),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _signIn(Models model) async {
    if (formKey.currentState.validate()) {
      if (widget.signUp == true) {
        model
            .signUp(
          _infoData['email'],
          _infoData['password'],
        )
            .then((value) {
          if (value['success'] == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(changeTheme: widget.changeTheme),
                ));
          } else {
            AlertWidget().alertWidget(context, 'ERROR', value['message']);
          }
        });
      } else {
        model.signIn(_infoData['email'], _infoData['password']).then((value) {
          if (value['success'] == false) {
            Navigator.pushReplacementNamed(context, 'homepage');
          } else {
            AlertWidget().alertWidget(context, 'ERROR', value['message']);
          }
        });
      }
    } else
      return null;
  }
}
