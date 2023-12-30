class Note {
  final int? id;
  final String title;
  final String mobileNumber;

  Note({this.id, required this.title, required this.mobileNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'mobileNumber': mobileNumber,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      mobileNumber: map['mobileNumber'],
    );
  }
}
