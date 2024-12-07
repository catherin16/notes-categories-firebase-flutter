import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';


// Simulación de un repositorio en memoria para almacenar notas
class NoteRepository {
  final List<NoteEntity> _notes = [];

  // Método para agregar una nueva nota
  void addNote(NoteEntity note) {
    _notes.add(note);
  }

  // Método para obtener todas las notas
  List<NoteEntity> getNotes() {
    return List.unmodifiable(_notes);
  }
}

void main() {
  test('debería crear una nueva nota correctamente', () {
    final noteRepository = NoteRepository();

    // Crear una nueva nota
    final newNote = NoteEntity(title: 'Nueva Nota', description: 'Descripción de la nueva nota');

    // Agregar la nueva nota al repositorio
    noteRepository.addNote(newNote);

    // Obtener todas las notas y verificar que la nueva nota fue agregada
    final notes = noteRepository.getNotes();

    // Verificar que el tamaño de la lista de notas es 1
    expect(notes.length, 1);

    // Verificar que la nota creada tiene el título correcto
    expect(notes[0].title, 'Nueva Nota');

    // Verificar que la nota creada tiene la descripción correcta
    expect(notes[0].description, 'Descripción de la nueva nota');
  });
}
