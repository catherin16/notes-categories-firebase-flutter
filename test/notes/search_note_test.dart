import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';




void main() {
  test('debería filtrar notas correctamente al buscar', () {
    final notes = [
      NoteEntity(title: 'Nota de trabajo', description: 'Descripción de trabajo'),
      NoteEntity(title: 'Nota personal', description: 'Descripción personal'),
      NoteEntity(title: 'Nota importante', description: 'Descripción importante'),
    ];

    List<NoteEntity> searchNotes(String query) {
      return notes.where((note) => note.title?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
    }

    final result1 = searchNotes('trabajo');
    expect(result1.length, 1);
    expect(result1[0].title, 'Nota de trabajo');

    final result2 = searchNotes('nota');
    expect(result2.length, 3);

    final result3 = searchNotes('importante');
    expect(result3.length, 1);
    expect(result3[0].title, 'Nota importante');

    final result4 = searchNotes('PERSONAL');
    expect(result4.length, 1);
    expect(result4[0].title, 'Nota personal');

    final result5 = searchNotes('');
    expect(result5.length, 3);

    final result6 = searchNotes('nota inexistente');
    expect(result6.length, 0);
  });
}
