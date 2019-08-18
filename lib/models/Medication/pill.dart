
class Pill{
  final List<dynamic> notificationIDs;
  final String pillName;
  final int dosage;
  final String pillType;
  final int interval;
  final String startTime;
  final String dateTime;
  final int adet;
  

  Pill ({
    this.notificationIDs,
    this.pillName,
    this.dosage,
    this.pillType,
    this.startTime,
    this.interval,
    this.adet,
    this.dateTime,
    
  });

  String get getName => pillName;
  int get getDosage => dosage;
  String get getType => pillType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;
  String get getDateTime => dateTime;
  int get getAdet => adet;
  

  Map<String,dynamic> toJson(){
    return {
      "ids": this.notificationIDs,
      "name": this.pillName,
      "dosage": this.dosage,
      "type": this.pillType,
      "interval": this.interval,
      "start": this.startTime,
      "adet": this.adet,
      "date": this.dateTime
      
    };
  }

  factory Pill.fromJson(Map<String, dynamic>parseJson){
    return Pill(
      notificationIDs: parseJson['ids'],
      pillName: parseJson['name'],
      dosage: parseJson['dosage'],
      pillType: parseJson['type'],
      interval: parseJson['interval'],
      startTime: parseJson['start'],
      dateTime:  parseJson['date'],
      adet: parseJson ['adet'],
      
    );
  }
}