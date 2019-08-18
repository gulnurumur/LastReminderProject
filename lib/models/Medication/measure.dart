
class Measure {
  final String date;
  final int time;
  final int value;

  Measure({
    this.date,
    this.time,
    this.value,
  });

  String get getDate => date;
  int get getTime => time;
  int get getValue => value;

  Map<String,dynamic>toJson(){
    return {
      "date": this.date,
      "time": this.time,
      "value": this.value,
    };
  }

  factory Measure.fromJson(Map<String,dynamic>parseJson){
    return Measure (
      date: parseJson['date'],
      time: parseJson['time'],
      value: parseJson['value'],
    );
  }

}