import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Result_list_view_model2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'category.dart';

class ikinciSayfa extends StatefulWidget {



  List<Category> categories2 = [
    Category('general', 'Genel',Icons.public),
    Category('entertainment', 'Eğlence',Icons.movie),
    Category('health', 'Sağlık',Icons.health_and_safety),
    Category('economy', 'Ekonomi',Icons.attach_money),


  ];



  List<GestureDetector> getCategoriesTab(ResultlistViewModel2 vm) {
    List<GestureDetector> list = [];
    for (int i = 0; i < categories2.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          vm.getNews2(categories2[i].key);
        },
        child: Card(
            color: Colors.amber.shade300,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 5.0),

              child: Row(
                  children: [
                  Icon(categories2[i].icon, color: Colors.black),
              SizedBox(width: 8.0),
              Text(
                categories2[i].title,
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
  State<ikinciSayfa> createState() => _ikinciSayfaState();
}

List<String>ulkeler = ['Türkiye(TR)','Almanya(DE)'];
String? secilenUlke;


class _ikinciSayfaState extends State<ikinciSayfa> {
  @override
  Widget build(BuildContext context) {
    final  vm= Provider.of<ResultlistViewModel2>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(' Almanya Haberleri',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            DropdownButton<String>(
              hint: Text('Ülke Seçiniz'),
              value: secilenUlke,
              onChanged:ulkeDegistir,

              items: ulkeler.map<DropdownMenuItem<String>>((String ulke){
                return DropdownMenuItem<String>(
                  value: ulke,
                  child: Row(
                    children:[
                      if(ulke == 'Türkiye(TR)')
                        Padding(
                          padding:EdgeInsets.only(right: 8.0),
                          child: Image.asset('assets/türkiyebayrakk.png',width: 40,height: 40),

                        ),
                      if (ulke == 'Almanya(DE)')
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Image.asset('assets/almanyabayrak.jpeg',width: 40,height: 40),


                        ),

                      Text(ulke),
                    ],
                  ),
                );
              },
              ).toList(),
            ),

          ],
        ),
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,

        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.getCategoriesTab(vm),
            ),

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
                        subtitle:
                        Text(vm.viewModel.result[index].description ?? '')
                        ,
                      ),
                      ButtonBar(
                        children: [
                          ElevatedButton.icon(onPressed: () async {
                            await launchUrl(Uri.parse(
                                vm.viewModel.result[index].url ?? ''
                            ));
                          },  icon: Icon(Icons.open_in_browser),
                            label: Text(
                              'Habere Git',
                              style: TextStyle(color: Colors.blue),
                            ),
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

  void ulkeDegistir(String? yeniUlke){
    if(yeniUlke!=null){
      setState(() {
        secilenUlke= yeniUlke;
      });
    }
    secilenUlke = yeniUlke!;
    if(secilenUlke=='Türkiye(TR)'){
      Navigator.pop(context);

    }
    setState(() {
      secilenUlke = 'Almanya(DE)';
    });



  }



}
