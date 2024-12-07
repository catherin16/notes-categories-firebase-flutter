import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity{
  NoteModel({
    String? id,
    String? title,
    String? description,
    String? category,
    DateTime? time,
     String? userId,
}) : super(id: id,title: title,description: description,time: time,category: category,userId: userId);

  factory NoteModel.fromFirestore(
      Map<String, dynamic> firestore,
      String id,
      ) {
    return NoteModel(
      id: id,
      title: firestore['title'],
      description: firestore['description'],
      category: firestore['category'],
      time: (firestore['time'] as Timestamp).toDate(),
      userId: firestore['userId'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
       'category': category,
      'time': Timestamp.fromDate(time!),
      'userId': userId
    };
  }
}