import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googlemapsflutter/components/tabbar.dart';
import 'package:googlemapsflutter/global_bloc.dart';
import 'package:googlemapsflutter/models/Medication/pill.dart';
import 'package:googlemapsflutter/ui/NewEntry/new_entry.dart';
import 'package:googlemapsflutter/ui/views/map.dart';
import 'package:googlemapsflutter/ui/views/measurement.dart';
import 'package:googlemapsflutter/ui/views/medicationPage.dart';
import 'package:googlemapsflutter/ui/views/pill_home.dart';
import 'package:googlemapsflutter/ui/views/search.dart';
import 'package:googlemapsflutter/ui/views/settings.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: new SafeArea(
        child: new Stack(
          children: <Widget>[
            new Center(
              child: Container(
                color: Color(0xFFF6F8FC), //golge kısım için.
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: TopContainer(),
                    ),
                    SizedBox(height: 10,),
                    Flexible(
                      flex:7,
                      child: Provider<GlobalBloc>.value(
                        child: BottomContainer(),
                        value: _globalBloc,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new MenuTabBar(
              background: Colors.blue,
              iconButtons: [
                new IconButton(
                  color: Colors.blue,
                  icon: new Icon(
                    Icons.home,
                    size: 30,
                  ),
                  onPressed: () {
                   //
                  },
                ),
                new IconButton(
                  color: Colors.blue,
                  icon: new Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Search(),
                    ));
                  },
                ),
                new IconButton(
                  color: Colors.blue,
                  icon: new Icon(
                    Icons.location_on,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(),
                        ));
                  },
                ),
                new IconButton(
                  color: Colors.blue,
                  icon: new Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> SettingPage(),
                    ));
                  },
                ),
              ],
              child: new Column( //animasyon kısmı + olan.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> NewEntry(),
                        ));
                      },
                      child: new Text(
                      "İlaç", //Medication
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  new Container(
                    child: new GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MeasurementPage(),
                        ));
                      },
                      child:  new Text(
                      "Ölçüm", //Measurement
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  new Container(
                    child: new GestureDetector(
                      onTap: (){},
                      child: new Text(
                      "Labaratuvar değerleri", //Lab values
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  new Container(
                    child: new GestureDetector(
                      onTap: (){},
                      child: new Text(
                      "Not", //Note
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  new Container(
                    child: new GestureDetector(
                      onTap: (){},
                      child: new Text(
                      "Barkod Okuyucu",//Barcode Scanner
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(0, 3.5),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0,3.5),
          ),
        ], 
        color: Colors.blue,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              " ",
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Colors.blue,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Kullanılan Toplam İlaç Sayısı:",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Pill>>(
            stream: globalBloc.pillList$,
            builder: (context,snapshot){
              return Padding(
                padding: EdgeInsets.only(top: 16.0,bottom: 5),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      fontFamily: "Neu",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Pill>>( //!!bakılacak-----------------
      stream: _globalBloc.pillList$,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
              child: Text(
                "Press + to add a reminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }else {
          return Container(
            color: Colors.white,
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return PillCard (snapshot.data[index]);
              },
            ),
          );
        } //!!-----------------------------------------------------------------------------
      }
    );
  }
}

class PillCard extends StatelessWidget {
  final Pill pill;

  PillCard (this.pill);

  Hero makeIcon(double size){
    if (pill.pillType == "Tablet"){
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    }else if(pill.pillType =="Surup"){
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          IconData(0xe901,fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    }else if(pill.pillType =="Diger"){
      return Hero(
        tag: pill.pillName + pill.pillType,
        child: Icon(
          IconData(0xe902,fontFamily: "Ic"),
          color: Colors.blue,
          size: size,
        ),
      );
    }
    return Hero(
      tag: pill.pillName + pill.pillType,
      child: Icon(
        Icons.error,
        color: Colors.blue,
        size:size,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: (){
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,Animation<double>secondaryAnimation){
                return AnimatedBuilder(
                  animation:animation,
                  builder: (BuildContext context, Widget child){
                    return Opacity(
                      opacity: animation.value,
                      child: MedicationPage(pill),
                    );
                  }
                );
              },
              transitionDuration: Duration(microseconds: 500),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(40.0),
                Hero(
                  tag: pill.pillName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      pill.pillName,
                      style:TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Text(
                  pill.interval ==1
                    ? "Her" + pill.interval.toString() + "saat"
                    : "Her" + pill.interval.toString() + "saatler",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
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