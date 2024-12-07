import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final DateTime? time;
  final String? userId;

  NoteEntity({
     this.id,
     this.title,
     this.category,
     this.description,
     this.time,
     this.userId
  });

  @override

  List<Object?> get props => [
    id,
    title,
    category,
    description,
    time,
    userId
  ];
}