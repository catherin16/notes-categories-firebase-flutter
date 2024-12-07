import 'package:notes_app/feature/data/models/note_model.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

abstract class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final NoteModel note;
  AddNoteEvent(this.note);
}

class UpdateNoteEvent extends NotesEvent {
  final NoteModel note;
  UpdateNoteEvent(this.note);
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;
  DeleteNoteEvent(this.noteId);
}
