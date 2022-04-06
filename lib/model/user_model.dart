class UserModel {
  UserModel({
    this.userName,
    this.age,
    this.bloodGroup,
    this.gender,
    this.phoneNumber,
    this.rhesusFactor,
  });

  String? userName;
  String? age;
  String? bloodGroup;
  String? gender;
  String? phoneNumber;
  String? rhesusFactor;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        gender: json["gender"],
        age: json["age"],
        phoneNumber: json["phoneNumber"],
        rhesusFactor: json["rhesusFactor"],
        bloodGroup: json["bloodGroup"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "gender": gender,
        "age": age,
        "phoneNumber": phoneNumber,
        "rhesusFactor": rhesusFactor,
        "bloodGroup": bloodGroup
      };
}
