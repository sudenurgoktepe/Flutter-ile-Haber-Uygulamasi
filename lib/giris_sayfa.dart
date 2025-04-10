import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class giris_sayfa extends StatefulWidget {
  @override
  _GirisSayfaState createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<giris_sayfa> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Sayfası',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
          backgroundColor: Colors.red
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'İsim'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = _controller.text;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('name', name);
                Navigator.pushReplacementNamed(context, '/karsilama');
              },
              child: Text('Giriş'),
            ),
          ],
        ),
      ),
    );
  }
}
