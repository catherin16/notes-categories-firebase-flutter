import 'package:notes_app/feature/domain/entities/note_entity.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<NoteEntity> notes;
  NotesLoadedState(this.notes);
}

class NoteErrorState extends NotesState {
  final String error;
  NoteErrorState(this.error);
}
