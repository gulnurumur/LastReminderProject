import 'package:flutter/material.dart';
import 'package:googlemapsflutter/ui/views/home.dart';
import 'package:provider/provider.dart';
import 'package:googlemapsflutter/global_bloc.dart';

void main() => runApp(Reminder());

//!! final routes tanımla
//TODO: ikinci sayfaya chart eklenecek!
//!! ilaçları localde tuttuğum zaman ana ekrana kaydetmiyor. Uygulamayı kapattığım zaman gidiyor.
//!! Maps kısmında geri tuşu çalışmıyor.
//todo: oluşturduğum ilaç veri tabanını uygulamaya aktarılacak.
//todo: ölçüm , labaravuvar değerleri ve not kısmı yapılacak. TASARIM: ilaç kısmı gibi olmalı!
//todo: barkod okuyucu yapıldı uygulamaya eklenecek!
//todo: maps kısmı arama butonu ile eczane aratabilmeliyim ve eklenilen cardlar o anda açık olan eczaneleri ve nöebtçileri bana göstermeli!
//todo ilaç oluşturma tarafında form kısmı checbox olarak değiştirelecek


//!!maps yerine chart eklenecek , geçmiş ilaçlar tutulacak, hangi ilacın günde kaç defa olduğunu ve gün içerisinde kaç defa kullanıp kullanmadığı bilgisi bu chartta gözükecek. 

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
/*class Reminder extends StatelessWidget {

    final routes = <String , WidgetBuilder>{
      LoginPage.tag: (context) => LoginPage(),
      SignPage.tag: (context) => SignPage(),
    };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
} */

/*class ReminderMain extends StatelessWidget {
  //HEX color çevirmek için
  hexColor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:
                        Color(hexColor('#191970')), //(midnight blue)
                  ),
                  child: new Icon(Icons.access_alarm, color: Colors.white),
                ),
                new Container(
                  margin:
                      new EdgeInsets.only(right: 20.0, top: 10.0, left: 50.0),
                  height: 70.0,
                  width: 70.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color:
                        Color(hexColor('#6495ED')), //(corn flower)
                  ),
                  child: new Icon(Icons.battery_std, color: Colors.white),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "HATIRLAT",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> LoginPage(),
                        ));
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        height: 55.0,
                        width: 55.0,
                        decoration: new BoxDecoration(
                          color: Color(hexColor('#191970')), //mavi olacak(deep)
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Text(
                          "Email ile Giriş Yap",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignPage(),
                        ));
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        height: 55.0,
                        width: 55.0,
                        decoration: new BoxDecoration(
                          color: Color(hexColor('#191970')), //mavi olacak(deep)
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Text(
                          "Üye Ol",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: new Container(
                        alignment: Alignment.center,
                        height: 55.0,
                        width: 55.0,
                        decoration: new BoxDecoration(
                          color: Color(hexColor('#FF0000')), //GOOGLE red olacak
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Text(
                          "Google",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: new Container(
                        alignment: Alignment.center,
                        height: 55.0,
                        width: 55.0,
                        decoration: new BoxDecoration(
                          color: Color(hexColor('#6495ED')), //mavi olacak(deep)
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Text(
                          "Misafir",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} */
