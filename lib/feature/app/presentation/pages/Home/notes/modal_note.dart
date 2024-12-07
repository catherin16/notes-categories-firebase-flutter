import 'package:flutter/material.dart';
import 'package:notes_app/feature/app/presentation/widgets/button/ButtonPrimary.dart';
import 'package:notes_app/feature/app/presentation/widgets/inputs/textFormField_outline.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class ModalNote extends StatelessWidget {
  final TextEditingController description;
  final  TextEditingController title;
  final NoteEntity?  note;
  final  Function(dynamic) onchange;
  final Function() onPress;
  final Function() onPressButton;

   ModalNote({super.key, required this.description, required this.title, required this.note,required this.onchange,required this.onPress,required this.onPressButton});

  @override
  Widget build(BuildContext context) {
    String? selectedCategory = note?.category;
    DateTime? selectedDate = note?.time;
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note == null ? "Crear nueva nota" : "Editar nota",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormFieldOutlineV2(
            controller: title,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Título',
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: description,
            maxLines: 2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white),
              ),
              hintText: 'Descripción',
              filled: true,
              fillColor: Colors.white,
            ),
          ),

          const SizedBox(height: 16),
          // Dropdown para categoría
          DropdownButton<String>(
            dropdownColor: Colors.white,
            value: selectedCategory,
            hint: const Text("Seleccionar categoría"),
            isExpanded: true,
            items: [
              "Trabajo",
              "Personal",
              "Estudio",
              "Otro"
            ].map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: onchange
          ),
          const SizedBox(height: 16),
          TextButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.black),
            ),
            onPressed: onPress,
            child: const Text("Seleccionar fecha"),
          ),
          const SizedBox(height: 20),
          Center(
            child: ButtonPrimary(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.blue,
              onPressed: onPressButton,
              title: note == null ? "Crear nota" : "Actualizar nota",
              titleStyle: const TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
