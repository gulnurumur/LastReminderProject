import 'dart:math';
import 'package:flutter/material.dart';
import 'package:googlemapsflutter/common/convert_time.dart';
import 'package:googlemapsflutter/global_bloc.dart';
import 'package:googlemapsflutter/models/Medication/errors.dart';
import 'package:googlemapsflutter/models/Medication/pill.dart';
import 'package:googlemapsflutter/models/Medication/pill_type.dart';
//!!home düzenlenecek
import 'package:googlemapsflutter/ui/NewEntry/new_entry_bloc.dart'; //new entry bloc eklenecek
import 'package:googlemapsflutter/ui/SuccesScreen/success_screen.dart';
import 'package:googlemapsflutter/ui/views/pill_home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController nameController;
  TextEditingController dosageController;
  TextEditingController adetController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;
  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    adetController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    adetController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        centerTitle: true,
        title: Text(
          "Hatırlatıcı oluştur",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              PanelTitle(
                title: "İlaç adı:",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 12,
                style: TextStyle(
                  fontSize: 16,
                ),
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Dosage(mg):",
                isRequired: false,
              ),
              TextFormField(
                controller: dosageController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              PanelTitle(
                title: "Adet:",
                isRequired: false,
              ),
              TextFormField(
                controller: adetController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PanelTitle(
                title: "Form:", //!!düzenlenecek
                isRequired: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<PillType>(
                  stream: _newEntryBloc.selectedPillType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PillTypeColumn(
                            type: PillType.Tablet,
                            name: "Tablet",
                            iconValue: 0xe900,
                            isSelected: snapshot.data == PillType.Tablet
                                ? true
                                : false),
                        PillTypeColumn(
                            type: PillType.Surup,
                            name: "Surup",
                            iconValue: 0xe901,
                            isSelected:
                                snapshot.data == PillType.Surup ? true : false),
                        PillTypeColumn(
                            type: PillType.Diger,
                            name: "Diger",
                            iconValue: 0xe902,
                            isSelected:
                                snapshot.data == PillType.Diger ? true : false),
                      ],
                    );
                  },
                ),
              ),
              PanelTitle(
                title: "Zaman:",
                isRequired: true,
              ),
              IntervalSelection(),
              PanelTitle(
                title: "Hatırlatmamı istediğin saat?",
                isRequired: true,
              ),
              SelectTime(),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Container(
                  width: 50,
                  height: 40,
                  child: FlatButton(
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    child: Center(
                      child: Text(
                        "Kaydet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {
                      //!! ERROR
                      String pillName;
                      int dosage;
                      int adet;
                      //validation kontrolleri
                      if (nameController.text == "") {
                        //pill name boş olamaz.Olursa
                        _newEntryBloc.submitError(EntryError.NameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        pillName = nameController.text;
                      }
                      if (dosageController.text == "") {
                        _newEntryBloc.submitError(EntryError.NameNull);
                        return;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      if(adetController.text == ""){
                        _newEntryBloc.submitError(EntryError.NameNull);
                      }
                      //if(adetController != ""){
                       // adet = adetController.text;
                     // }
                      for (var pill in _globalBloc.pillList$.value) {
                        if (pillName == pill.pillName) {
                          _newEntryBloc.submitError(EntryError.NameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectedInterval$.value == 0) {
                        _newEntryBloc.submitError(EntryError.Interval);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                        _newEntryBloc.submitError(EntryError.StartTime);
                        return;
                      }
                      
                      //!!-----------------------------------------------------------------
                      String pillType = _newEntryBloc.selectedPillType.value
                          .toString()
                          .substring(13);
                      int interval = _newEntryBloc.selectedInterval$.value;
                      String startTime = _newEntryBloc.selectedTimeOfDay$.value;
                      String dateTime = _newEntryBloc.selectDate$.value;

                      List<int> intIDs =
                          makeIDs(24 / _newEntryBloc.selectedInterval$.value);
                      List<String> notificationIDs =
                          intIDs.map((i) => i.toString()).toList();

                      Pill newEntryPill = Pill(
                        notificationIDs: notificationIDs,
                        pillName: pillName,
                        dosage: dosage,
                        adet: adet,
                        pillType: pillType,
                        interval: interval,
                        startTime: startTime,
                        dateTime: dateTime,
                        

                      );

                      _globalBloc.updatePillList(newEntryPill);
                      scheduleNotification(newEntryPill);

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SuccessScreen();
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen((EntryError error) {
      switch (error) {
        case EntryError.NameNull:
          displayError("Lütfen ilaç adını giriniz");
          break;
        case EntryError.NameDuplicate:
          displayError("Bu ilacı zaten ekledin");
          break;
        //case EntryError.DosageNull:
        // displayError("Please enter the dosage");
        // break;
        case EntryError.Dosage:
          displayError("Lütfen dosage giriniz");
          break;
        case EntryError.Adet:
          displayError("Lütfen ikaç adetini giriniz");
          break;
        case EntryError.Interval:
          displayError("Lütfen ilac zamanını seçiniz");
          break;
        case EntryError.StartTime:
          displayError("Lütfen ilacın hatırlatma zamanını giriniz");
          break;
        case EntryError.StartDate:
          displayError("Lütfen ilacın hatırlatma tarihini giriniz");
          break;
        default:
      }
    });
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var range = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(range.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload:' + payload);
    }
    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => PillHome(), //!!homepage eklenecek düzenlenip.
        ));
  }

  Future<void> scheduleNotification(Pill pill) async {
    var hour = int.parse(pill.startTime[0] + pill.startTime[1]);
    var ogValue = hour;
    var minute = int.parse(pill.startTime[2] + pill.startTime[3]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.Max,
      sound: "sound",
      ledColor: Color(0xFF3EB16F),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    for (int i = 0; i < (24 / pill.interval).floor(); i++) {
      if ((hour + (pill.interval * i) > 23)) {
        hour = hour + (pill.interval * i) - 24;
      } else {
        hour = hour + (pill.interval * i);
      }
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        int.parse(pill.notificationIDs[i]),
        'Reminder: ${pill.pillName}',
        pill.pillType.toString() != PillType.None.toString()
            ? ' ${pill.pillType.toLowerCase()}, ilacını içme zamanı' //gelen bildiriim mesajı
            : 'İlaç içme zamanın geldi tatlım',
        Time(hour, minute, 0),
        platformChannelSpecifics,
      ); //id,title,notificationTime,notificationDetails
      hour = ogValue;
    }
  }
}

class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    6,
    8,
    12,
    24,
  ];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Her ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              iconEnabledColor: Colors.blue,
              hint: _selected == 0
                  ? Text(
                      "Kaç saatte bir ?",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
            Text(
              _selected == 1 ? "saat" : "saat",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SelectDate extends StatefulWidget {
  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: FlatButton(
          color: Colors.blue,
          shape: StadiumBorder(),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Saati seç"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PillTypeColumn extends StatelessWidget {
  final PillType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  PillTypeColumn({
    Key key,
    @required this.type,
    @required this.name,
    @required this.iconValue,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedPill(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Colors.blue : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : Colors.blue, //boxes colors
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isSelected ? Colors.white : Colors.blue, //text colors
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ]),
      ),
    );
  }
}
