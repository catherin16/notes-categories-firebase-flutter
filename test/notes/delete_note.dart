import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';



// Simulación de un repositorio en memoria para almacenar notas
class NoteRepository {
  final List<NoteEntity> _notes = [];


  bool deleteNoteByTitle(String title) {
    final noteToDelete = _notes.firstWhere(
          (note) => note.title == title,
      orElse: () => null!,
    );

    if (noteToDelete != null) {
      _notes.remove(noteToDelete);
      return true;
    }
    return false; // Si no se encontró la nota
  }

  // Método para obtener todas las notas
  List<NoteEntity> getNotes() {
    return List.unmodifiable(_notes);
  }
}

void main() {
  test('debería eliminar una nota correctamente', () {
    final noteRepository = NoteRepository();

    final note1 = NoteEntity(title: 'Nota 1', description: 'Descripción de la Nota 1');
    final note2 = NoteEntity(title: 'Nota 2', description: 'Descripción de la Nota 2');
    noteRepository._notes.add(note1);
    noteRepository._notes.add(note2);

    expect(noteRepository.getNotes().length, 2);

    final isDeleted = noteRepository.deleteNoteByTitle('Nota 1');


    expect(isDeleted, true);


    expect(noteRepository.getNotes().length, 1);


    expect(noteRepository.getNotes().any((note) => note.title == 'Nota 1'), false);


    expect(noteRepository.getNotes().any((note) => note.title == 'Nota 2'), true);
  });
}
