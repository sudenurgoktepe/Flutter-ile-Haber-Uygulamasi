import 'package:flutter/material.dart';
import 'package:haberuygulama/Result_list_view_model2.dart';
import 'package:haberuygulama/ikinci_sayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'ana_sayfa.dart';
import 'giris_sayfa.dart';
import 'package:haberuygulama/karsilama_sayfasi.dart';
import 'Result_list_view_model.dart';

void main() {
  runApp(AnaUygulama());
}

class AnaUygulama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider( create: (context) => ResultlistViewModel()),
       ChangeNotifierProvider( create: (context) => ResultlistViewModel2()),

    ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<String?>(
          future: kullaniciAdiAl(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasData && snapshot.data != null) {
              return KarsilamaSayfasi(kullaniciAdi: snapshot.data!);
            } else {
              return giris_sayfa();
            }
          },
        ),
        routes: {
          '/giriş': (context) => giris_sayfa(),
          '/karsilama': (context) => KarsilamaSayfasi(kullaniciAdi: ''),
          '/ana': (context) => AnaSayfa(),
          '/ikinciSayfa': (context) => ikinciSayfa(),
        },
      ),
    );
  }

  Future<String?> kullaniciAdiAl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
}
