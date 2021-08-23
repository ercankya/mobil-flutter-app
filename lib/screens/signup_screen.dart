import 'package:fal_zamani/modals/authentication.dart';
import 'package:fal_zamani/screens/home_screen.dart';
import 'package:fal_zamani/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordState = new TextEditingController();

  Map<String, String> _authData = {"email": '', "password": ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap oluştur"),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text("Giriş"),
                Icon(Icons.person),
              ],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.blueGrey,
              Colors.blue,
            ])),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(75.0)),
              child: Container(
                height: 400,
                width: 350,
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email inputfield
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Geçersiz email adresi";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData["email"] = value;
                          },
                        ),
                        //password inputField
                        TextFormField(
                          decoration: InputDecoration(labelText: "Şifre"),
                          obscureText: true,
                          controller: _passwordState,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 6) {
                              return "Geçersiz Şifre";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData["password"] = value;
                          },
                        ),
                        //Confirm Password inputField
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Şifreyi Doğrula"),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value != _passwordState.text) {
                              return "Doğrulama şifresi eşleşmiyor";
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text("Üye ol"),
                          onPressed: () {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
