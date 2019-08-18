import 'package:googlemapsflutter/models/Medication/errors.dart';
//import 'package:googlemapsflutter/models/Medication/pill.dart';
import 'package:googlemapsflutter/models/Medication/pill_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  BehaviorSubject<PillType> _selectedPillType$;
  BehaviorSubject<PillType> get selectedPillType => _selectedPillType$.stream;

  BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$; //zaman

  BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$; //zaman kontrol

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  BehaviorSubject<String> _selectDate$;
  BehaviorSubject<String> get selectDate$ => _selectDate$;



 

  NewEntryBloc (){
    _selectedPillType$ = BehaviorSubject<PillType>.seeded(PillType.None);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
    _selectDate$ = BehaviorSubject<String>.seeded("None"); 
    
    
  }

  void dispose(){
    _selectedPillType$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
    _selectDate$.close();
    
  
  }


  void submitError(EntryError error){
    _errorState$.add(error);
  }

  void updateInterval(int interval){
    _selectedInterval$.add(interval);
  }

  void updateTime(String time){
    _selectedTimeOfDay$.add(time);
  }

  void updateSelectedPill (PillType type){
    PillType _tempType = _selectedPillType$.value;
    if(type == _tempType){
      _selectedPillType$.add(PillType.None);
    }else {
      _selectedPillType$.add(type);
    }
  }

  void updateDay (String day){
    _selectDate$.add(day);
  }
}