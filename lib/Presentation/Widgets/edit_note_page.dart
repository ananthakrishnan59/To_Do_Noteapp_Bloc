import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_note_bloc/Bloc/note_bloc.dart';
import 'package:to_do_note_bloc/Core/colors.dart';
import 'package:to_do_note_bloc/Core/constants.dart';
import 'package:to_do_note_bloc/Model/note_model.dart';
import 'package:to_do_note_bloc/Presentation/Widgets/add_custom_textfield.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required this.notes});
  final NoteModel notes;
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    titleController = TextEditingController(text: widget.notes.title);
    descriptionController =
        TextEditingController(text: widget.notes.description);
    debugPrint(widget.notes.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime inputDateTime = DateTime.parse(widget.notes.createdAt!);
    String formattedDateTime =
        DateFormat('hh:mm a | dd MMM yyyy').format(inputDateTime);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: const Text('Edit Note',style: TextStyle(color:kwhite),),
      ),
      body: Container(
        color: kbackgroundcolor,
        child: Column(
          
          children: [
            const Divider(),
            SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AddCustomTextField(
                          controller: titleController,
                          hintText: 'Title',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 18,
                          ),
                          kWidth(5),
                          const Text(
                            'Date Created : ',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            formattedDateTime,
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      const Divider(),
                      AddCustomTextField(
                          controller: descriptionController,
                          hintText: 'Write your notes here.....',
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ],
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == .0,
          child: MaterialButton(
            height: 50,
            color: kBlue,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final updatedNote = NoteModel(
                    id: widget.notes.id,
                    title: titleController.text,
                    description: descriptionController.text);
                context
                    .read<NoteBloc>()
                    .add(NoteUpdateEvent(note: updatedNote));
              }
              context.read<NoteBloc>().add(NoteInitialFetchingEvent());
              Navigator.pop(context);
            },
            child: const Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    ));
  }
}
