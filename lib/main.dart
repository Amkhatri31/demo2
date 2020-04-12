import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<Data>(builder: (context,model,_){
        return Text(model.text);
      })
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).text);
  }
}

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: TextEditingController(),
          onChanged: (value){
            Provider.of<Data>(context,listen: false).changeString(value);
            print("inside onchanged");
          },
        ),
      ],
    );
  }
}

class Data with ChangeNotifier {
  String text = 'Some Data';

  changeString(String newString) {
    text = newString;
    print(text);// this is not executed when running
    notifyListeners();
  }
}
