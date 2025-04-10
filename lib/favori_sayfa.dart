import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriSayfa extends StatefulWidget {
  @override
  _FavoriSayfaState createState() => _FavoriSayfaState();
}

class _FavoriSayfaState extends State<FavoriSayfa> {
  List<String> favoriHaberler = [];

  @override
  void initState() {
    super.initState();
    _favoriHaberleriYukle();
  }

  void _favoriHaberleriYukle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? kaydedilenFavoriler = prefs.getStringList('favoriHaberler');
    if (kaydedilenFavoriler != null) {
      setState(() {
        favoriHaberler = kaydedilenFavoriler;
      });
    }
  }

  void _favoriHaberKaldir(String haberUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriHaberler.remove(haberUrl);
      prefs.setStringList('favoriHaberler', favoriHaberler);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Favori Haberler'),
      ),
      body: ListView.builder(
        itemCount: favoriHaberler.length,
        itemBuilder: (context, index) {
          String haberUrl = favoriHaberler[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    haberUrl,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _favoriHaberKaldir(haberUrl);
                    },
                  ),
                ),
                ButtonBar(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (await canLaunch(haberUrl)) {
                          await launch(haberUrl);
                        }
                      },
                      icon: Icon(Icons.open_in_browser),
                      label: Text('Habere Git'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
