import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  String title;
  String description;
  String date;
  int colorIndex;
  NoteModel({
    required this.title,
    required this.description,
    required this.date,
    required this.colorIndex,
  });

  NoteModel copyWith({
    String? title,
    String? description,
    String? date,
    int? colorIndex,
  }) {
    return NoteModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
      'colorIndex': colorIndex,
    };
  }

  factory NoteModel.fromMap(Map<dynamic, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      colorIndex: map['colorIndex'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(title: $title, description: $description, date: $date, colorIndex: $colorIndex)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.date == date &&
        other.colorIndex == colorIndex;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        colorIndex.hashCode;
  }
}
