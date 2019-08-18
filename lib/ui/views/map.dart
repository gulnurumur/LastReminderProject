import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {},
        ),
        title: Text("Eczaneler"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(
          Icons.zoom_out_map,
          color: Colors.blue,
        ),
        onPressed: () {
          zoomVal--;
          _minus(zoomVal);
        },
      ),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(
          Icons.zoom_out_map,
          color: Colors.blue,
        ),
        onPressed: () {
          zoomVal++;
          _minus(zoomVal);
        },
      ),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(40.972858, 29.152759),
      zoom: zoomVal,
    )));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Padding(
              //Açıklama kartı oluşturuldu.
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  41.024468,
                  29.041312,
                  "Gültekin Eczanesi" //Image error.
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  40.984271,
                  29.024391,
                  "Birol Eczane"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  40.984898,
                  29.024417,
                  "Ertem Eczane"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  40.985432,
                  29.025066,
                  "Yeni Moda Eczanesi"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  40.984132,
                  29.024233,
                  "Moda Zırhlıoğlu Eczanesi"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.google.com/search?q=yeditepe+sosyal+tesisler&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj4r-HPssjjAhWQwcQBHaONAI0Q_AUIEigC&biw=1440&bih=789#imgrc=NEAvZ-JhWwyjSM:",
                  40.985646, 29.025601,
                  "Ozan Eczanesi"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String partName) {
    return GestureDetector(
      onTap: () {
        _gottoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer(partName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer(String partName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              partName,
              style: TextStyle(
                  color: Color(0xff6200ee),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "4.1",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Text(
                  "(946)",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          child: Text(
            "",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          child: Text(
            "",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.972858, 29.152759),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          eczaneMarker1,
          eczaneMarker2,
          eczaneMarker3,
          eczaneMarker4,
          eczaneMarker5,
          eczaneMarker6,
        },
      ),
    );
  }

  Future<void> _gottoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(lat, long), zoom: 15, tilt: 50.0, bearing: 45.0),
    ));
  }
}

Marker eczaneMarker1 = Marker(
  markerId: MarkerId("eczaneMarker1"),
  position: LatLng(41.024468, 29.041312),
  infoWindow: InfoWindow(title: 'Gültekin Eczanesi'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
);

Marker eczaneMarker2 = Marker(
  //Moda eczaneleri
  markerId: MarkerId("eczaneMarker2"),
  position: LatLng(40.984271, 29.024391),
  infoWindow: InfoWindow(title: 'Eczane Birol'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
);

Marker eczaneMarker3 = Marker(
  //Moda eczaneleri
  markerId: MarkerId("eczaneMarker3"),
  position: LatLng(40.984898, 29.024417),
  infoWindow: InfoWindow(title: 'Ertem Eczane'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
);

Marker eczaneMarker4 = Marker(
  //Moda eczaneleri
  markerId: MarkerId("eczaneMarker4"),
  position: LatLng(40.985432, 29.025066),
  infoWindow: InfoWindow(title: 'Yeni Moda Eczanesi'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
);

Marker eczaneMarker5 = Marker(
  markerId: MarkerId("eczaneMarker5"), //Moda eczaneleri
  position: LatLng(40.984132, 29.024233),
  infoWindow: InfoWindow(title: "Moda Zırhlıoğlu Eczanesi"),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
);
Marker eczaneMarker6 = Marker(
    markerId: MarkerId("eczaneMarker6"),
    position: LatLng(40.985646, 29.025601),
    infoWindow: InfoWindow(title: "Ozan Eczane"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
