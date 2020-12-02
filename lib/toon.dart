class Toon {
  final String toonId;
  final String lastName;
  final String firstName;
  final String occupation;
  final String pictureUrl;

  Toon(this.toonId, this.firstName, this.lastName, this.occupation,
      this.pictureUrl);

  factory Toon.fromJson(Map<String, dynamic> json) {
    return Toon(
      json['id'].toString(),
      json['lastName'],
      json['firstName'],
      json['occupation'],
      json['pictureUrl'],
    );
  }
}
