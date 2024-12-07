import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/notes/notes_event.dart';
import 'package:notes_app/feature/app/presentation/bloc/notes/notes_state.dart';
import 'package:notes_app/feature/data/models/note_model.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  NotesBloc(this._firebaseFirestore, this._firebaseAuth) : super(NotesInitialState()) {
    on<LoadNotesEvent>(_onLoadNotesEvent);
    on<AddNoteEvent>(_onAddNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
  }

  Future<void> _onLoadNotesEvent(LoadNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        emit(NoteErrorState('Usuario no autenticado'));
        return;
      }

      final snapshot = await _firebaseFirestore
          .collection('notas')
          .where('userId', isEqualTo: userId) // Filtra por el userId
          .get();

      final notes = snapshot.docs
          .map((doc) => NoteModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NoteErrorState('Error al cargar las notas'));
    }
  }

  Future<void> _onAddNoteEvent(AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        emit(NoteErrorState('Usuario no autenticado'));
        return;
      }

      final noteData = event.note.toFirestore();
      noteData['userId'] = userId;

      await _firebaseFirestore.collection('notas').add(noteData);
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState('Error al agregar la nota'));
    }
  }
  Future<void> _onUpdateNoteEvent(UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await _firebaseFirestore
          .collection('notas')
          .doc(event.note.id)
          .update(event.note.toFirestore());

      // Actualiza solo la nota en el estado actual
      if (state is NotesLoadedState) {
        final currentNotes = (state as NotesLoadedState).notes;
        final updatedNotes = currentNotes.map((note) {
          if (note.id == event.note.id) {
            return event.note;
          }
          return note;
        }).toList();

        emit(NotesLoadedState(updatedNotes));
      }
    } catch (e) {
      emit(NoteErrorState('Error al actualizar la nota'));
    }
  }


  Future<void> _onDeleteNoteEvent(DeleteNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await _firebaseFirestore.collection('notas').doc(event.noteId).delete();
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState('Error al eliminar la nota'));
    }
  }
}
