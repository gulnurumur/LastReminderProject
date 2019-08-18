import 'dart:convert';
import 'models/Medication/pill.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {

  BehaviorSubject <List<Pill>> _pillList$;
  BehaviorSubject <List<Pill>> get pillList$ => _pillList$;

  GlobalBloc (){
    _pillList$ = BehaviorSubject<List<Pill>>.seeded([]);
    makePillList();
  }

  //list all pill
  Future makePillList () async{
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('pills');
    List<Pill> prefList =[];
    if(jsonList == null){
      return;
    }else {
      for (String jsonPill in jsonList){
        Map userMap = jsonDecode(jsonPill);
        Pill tempPill = Pill.fromJson(userMap);
        prefList.add(tempPill);
      }
      _pillList$.add(prefList);
    }
  }

  //remove all pill list
  Future removePill (Pill tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> pillJsonList = [];

    var blocList = _pillList$.value;
    blocList.removeWhere(
      (pill)=> pill.pillName == tobeRemoved.pillName
    );

    for(int i = 0; i < (24 / tobeRemoved.interval).floor(); i++){
      flutterLocalNotificationsPlugin
      .cancel(int.parse(tobeRemoved.notificationIDs[i]));
    }
    if(blocList.length != 0){
      for(var blocPill in blocList){
        String pillJson = jsonEncode(blocPill.toJson());
        pillJsonList.add(pillJson);
      }
    }
    sharedUser.setStringList('pill', pillJsonList);  //(key,value)
    _pillList$.add(blocList);
  }

  //update pill list
  Future updatePillList (Pill newPill) async {
    var blocList = _pillList$.value;
    blocList.add(newPill);
    _pillList$.add(blocList);

    Map<String , dynamic> tempMap = newPill.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newPillJson = jsonEncode(tempMap);
    List <String> pillJsonList = [];
    if(sharedUser.getStringList('pill') == null){
      pillJsonList.add(newPillJson);
    }else {
      pillJsonList = sharedUser.getStringList('pill');
      pillJsonList.add(newPillJson);
    }
    sharedUser.setStringList('pill',pillJsonList);

  }

  void dispose(){
    _pillList$.close();
  }

}