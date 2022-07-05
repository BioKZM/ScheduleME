class FUser {
  final String? userid;

  FUser({this.userid});
}

class UserData {
  final String? userid;
  final String? name;
  final String? surname;
  final String? department;
  final Map<String, dynamic>? courses;
  final Map<String, dynamic>? groups;
  final Map<String, dynamic>? plans;

  UserData(
      {this.userid,
      this.name,
      this.surname,
      this.courses,
      this.groups,
      this.plans,
      this.department});
}
