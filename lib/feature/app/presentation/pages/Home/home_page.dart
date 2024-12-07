import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/notes/notes_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/notes/notes_event.dart';
import 'package:notes_app/feature/app/presentation/bloc/notes/notes_state.dart';
import 'package:notes_app/feature/app/presentation/pages/Home/notes/input_search.dart';
import 'package:notes_app/feature/app/presentation/pages/Home/notes/modal_note.dart';
import 'package:notes_app/feature/app/presentation/pages/Home/notes/notes_card.dart';
import 'package:notes_app/feature/app/presentation/pages/Home/notes/title_ui.dart';
import 'package:notes_app/feature/data/models/note_model.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(LoadNotesEvent());
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _selectedCategory = null;
      _isSearching = false;
    });
    context.read<NotesBloc>().add(LoadNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            const TittleUi(),
            const SizedBox(height: 30),
            InputSearch(search: _searchController,
              onchange: (value) {
                setState(() {
                  _selectedCategory = value.isEmpty ? null : value;
                  _isSearching = value.isNotEmpty;
                });
              },
              onPress: () { _isSearching ? _clearSearch : null; },
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (state is NotesLoadedState) {
                  final filteredNotes = _selectedCategory == null
                      ? state.notes
                      : state.notes.where((note) {
                    final searchLower = _selectedCategory!.toLowerCase();
                    return (note.title?.toLowerCase().contains(searchLower) ?? false) ||
                        (note.description?.toLowerCase().contains(searchLower) ?? false) ||
                        (note.category?.toLowerCase().contains(searchLower) ?? false);
                  }).toList();

                  if (filteredNotes.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay notas ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: filteredNotes.map((note) {
                            return NotesCard(
                              title: note.title ?? '',
                              description: note.description ?? '',
                              date: note.time!,
                              category: note.category ?? 'Sin categoría',
                              onEdit: () {
                                _showCreateNoteModal(context, note);
                              },
                              onDelete: () {
                                BlocProvider.of<NotesBloc>(context).add(
                                  DeleteNoteEvent(note.id!),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                } else if (state is NoteErrorState) {
                  return Center(child: Text(state.error));
                } else {
                  return const Center(child: Text('No hay notas'));
                }
              },
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateNoteModal(context, null);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }



  void _showCreateNoteModal(BuildContext context, NoteEntity? note) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final descriptionController = TextEditingController(
        text: note?.description ?? '');
    String? selectedCategory = note?.category;
    DateTime? selectedDate = note?.time;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ModalNote(
              description: descriptionController,
              title: titleController,
              note: note,
              onchange: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              onPress: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              onPressButton: () {
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, complete todos los campos')),
                  );
                  return;
                }

                final newNote = NoteModel(
                  id: note?.id!, // Asegúrate de que el ID no esté vacío
                  title: titleController.text,
                  description: descriptionController.text,
                  category: selectedCategory,
                  time: selectedDate ?? DateTime.now(),
                );

                if (note == null) {
                  BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(newNote));
                } else {
                  BlocProvider.of<NotesBloc>(context).add(
                      UpdateNoteEvent(newNote));
                }

                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

}
