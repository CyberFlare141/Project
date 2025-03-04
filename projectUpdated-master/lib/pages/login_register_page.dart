import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key?key}): super(key:key);
  @override
  State<LoginPage> createState()=> _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  String? errorMessage='';
  bool isLogin=true;

  final TextEditingController _controllerEmail=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try{
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch(e){
      setState(() {

        errorMessage=e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage=e.message;
      });
    }
  }
  Widget _title(){
    return const Text('Campus Bazaar');
  }
  Widget _entryField(
      String title,
      TextEditingController controller,
      ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: title,

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        )
    ),
    );
  }
  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Hum ? $errorMessage');
  }
  Widget _submitButton(){
    return ElevatedButton(
        onPressed:
        isLogin ? signInWithEmailAndPassword :createUserWithEmailAndPassword,
        child: Text(isLogin? 'Login':'Register'),
    );
  }
  Widget _loginOrRegisterButton(){
    return TextButton(
        onPressed: (){
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin? 'Register Instead':'Login Instead'),
    );
  }

  @override
  Widget build(BuildContext context){
   /* return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),

          ],
        ),
      ),
    );*/
    return Container(
      decoration: BoxDecoration(

        image: DecorationImage(
          image: AssetImage(isLogin? 'assets/useLogIn.png':'assets/useRegistration.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35,top: 130),
              child: Text(isLogin?'Welcome\nBack,\nUser':'Who\nAre\nYou?\nStranger',style:
                TextStyle(color: Colors.black54,
                fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),

              ),


            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5, right: 35,left: 35),
                child: Column(
                  children: [

                    _entryField('Email?', _controllerEmail),


                    SizedBox(
                      height: 20,
                    ),

                    _entryField('Password?', _controllerPassword),

                    SizedBox(
                      height: 40,
                    ),
                _errorMessage(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(isLogin? 'Login':'Register',style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                        ),
                        _submitButton(),
                        /*CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade800,
                          child: IconButton(
                            color: Colors.white,
                              onPressed: (){
                                isLogin ? signInWithEmailAndPassword :createUserWithEmailAndPassword;
                                Text(isLogin? 'Login':'Register');
                              },
                              icon: Icon(Icons.arrow_forward),
                          ),
                        ),*/

                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          setState(() {
                            isLogin = !isLogin;
                          });
                        }, child:Text(isLogin? 'Register Instead':'Login Instead',style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 19,
                          color: Colors.grey.shade800,
                        ),)),
                        TextButton(onPressed: (){}, child:Text('Forgot Password',style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 19,
                          color: Colors.grey.shade800,
                        ),))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}