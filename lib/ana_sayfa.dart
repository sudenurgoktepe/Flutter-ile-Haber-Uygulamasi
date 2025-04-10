import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haberuygulama/ikinci_sayfa.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haberuygulama/Result_list_view_model.dart';
import 'package:haberuygulama/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favori_sayfa.dart';

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<String> ulkeler = ['Türkiye(TR)', 'Almanya(DE)'];
  String? secilenUlke;

  List<Category> categories = [
    Category('general', 'Genel', Icons.public),
    Category('entertainment', 'Eğlence', Icons.movie),
    Category('technology', 'Teknoloji', Icons.devices),
    Category('economy', 'Ekonomi', Icons.attach_money),
  ];
  String kategorisecmebaslik = 'Genel';

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

  void _toggleFavori(String haberUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriHaberler.contains(haberUrl)) {
        favoriHaberler.remove(haberUrl);
      } else {
        favoriHaberler.add(haberUrl);
      }
      prefs.setStringList('favoriHaberler', favoriHaberler);
    });
  }

  bool _isFavori(String haberUrl) {
    return favoriHaberler.contains(haberUrl);
  }

  void kategorisec(String title) {
    setState(() {
      kategorisecmebaslik = title;
    });
  }

  List<GestureDetector> getCategoriesTab(ResultlistViewModel vm) {
    List<GestureDetector> list = [];
    for (int i = 0; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          kategorisec(categories[i].title);
          vm.getNews(categories[i].key);
        },
        child: Card(
          color: Colors.amber.shade300,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 5.0),
            child: Row(
              children: [
                Icon(categories[i].icon, color: Colors.black),
                SizedBox(width: 8.0),
                Text(
                  categories[i].title,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ResultlistViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' Türkiye Haberleri',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),


            DropdownButton<String>(
              hint: Text('Ülke Seçiniz'),
              value: secilenUlke,
              onChanged: ulkeDegistir,


              items: ulkeler.map<DropdownMenuItem<String>>((String ulke) {
                return DropdownMenuItem<String>(
                  value: ulke,
                  child: Row(
                    children: [
                      if (ulke == 'Türkiye(TR)')
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Image.asset('assets/türkiyebayrakk.png', width: 40, height: 40),
                        ),
                      if (ulke == 'Almanya(DE)')
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Image.asset('assets/almanyabayrak.jpeg', width: 40, height: 40),
                        ),
                      Text(ulke),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getCategoriesTab(vm),
            ),
          ),
          if (kategorisecmebaslik.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '$kategorisecmebaslik Haberler',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
            ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriSayfa()),
              );
            },
          ),

          Expanded(
            child: ListView.builder(
              itemCount: vm.viewModel.result.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(
                        vm.viewModel.result[index].image ??
                            'https://navikurumsal.com/wp-content/themes/consultix/images/no-image-found-360x250.png',
                      ),
                      ListTile(
                        title: Text(
                          vm.viewModel.result[index].title ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(vm.viewModel.result[index].description ?? ''),
                      ),
                      ButtonBar(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final url = vm.viewModel.result[index].url;
                              if (url != null && await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            icon: Icon(Icons.open_in_browser),
                            label: Text(
                              'Habere Git',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isFavori(vm.viewModel.result[index].url ?? '')
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _toggleFavori(vm.viewModel.result[index].url ?? '');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void ulkeDegistir(String? yeniUlke) {
    if (yeniUlke != null) {
      setState(() {
        secilenUlke = yeniUlke;
      });
    }
    secilenUlke = yeniUlke!;
    if (secilenUlke == 'Almanya(DE)') {
      setState(() {
        ikinciSayfayiAc(context);
      });
    }
  }

  Future<void> ikinciSayfayiAc(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return ikinciSayfa();
      }),
    );
    setState(() {
      secilenUlke = 'Türkiye(TR)';
    });
  }
}
