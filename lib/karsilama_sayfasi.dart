import 'package:flutter/material.dart';

class KarsilamaSayfasi extends StatelessWidget {
  final String? kullaniciAdi;

  KarsilamaSayfasi({this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hoşgeldin $kullaniciAdi',
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
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/resim3.png',width: 500,height: 500,),
                SizedBox(height: 30),
                Text(
                  'Aradığınız güncel haberler burada!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/ana');
                  },
                  child: Text('Tıklayın!'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
