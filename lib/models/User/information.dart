


class UserInformation {
   int age;
   String gender;
   String yearOfBirth;
   int height;
   int weight;

   UserInformation ({
     this.age,
     this.gender,
     this.height,
     this.weight,
     this.yearOfBirth,
   });

  int get getAge => age;
  String get getGender => gender;
  String get getYearOfBirth => yearOfBirth;
  int get getHeight => height;
  int get getWeight => weight;

  Map<String, dynamic> toJson(){
    return {
      "age": this.age,
      "gender": this.gender,
      "birth": this.yearOfBirth,
      "height": this.height,
      "weight": this.weight,
    };
  }

  factory UserInformation.fromJson(Map<String,dynamic>parseJson){
    return UserInformation(
      age:parseJson['age'],
      gender:parseJson['gender'],
      yearOfBirth:parseJson['yearOfBirth'],
      height:parseJson['height'],
      weight:parseJson['weight'],
    );
  }


}