import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_note_bloc/Bloc/note_bloc.dart';
import 'package:to_do_note_bloc/Core/colors.dart';
import 'package:to_do_note_bloc/Core/constants.dart';
import 'package:to_do_note_bloc/Presentation/Widgets/add_note_page.dart';
import 'package:to_do_note_bloc/Presentation/Widgets/edit_note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<NoteBloc>().add(NoteInitialFetchingEvent());
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlue,
          title: const Text(
            'ADD NOTE',
            style: TextStyle(color: kwhite),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<NoteBloc, NoteState>(
          listenWhen: (previous, current) => current is NoteActionState,
          buildWhen: (previous, current) => current is! NoteActionState,
          listener: (context, state) {
            if (state is NoteAddSucessActionState) {
              Navigator.pop(context);
              customSnackbar(context, 'New note added');
            } else if (state is NoteAddErrorActionState) {
              customSnackbar(context, 'Error creating new note');
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case NoteFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(
                    color: kBlue,
                  ),
                );
              case NoteFetchingSucessState:
                final successState = state as NoteFetchingSucessState;

                return successState.notes.isNotEmpty
                    ? ListView.builder(
                        itemCount: successState.notes.length,
                        itemBuilder: (context, index) {
                          DateTime inputDateTime = DateTime.parse(
                              successState.notes[index].createdAt!);
                          String formattedDateTime =
                              DateFormat('hh:mm a | dd MMM yyyy')
                                  .format(inputDateTime);
                          return Container(
                            height: 300,
                            color: kbackgroundcolor,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      successState.notes[index].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(formattedDateTime)
                                  ],
                                ),
                                Text(successState.notes[index].description),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditNotePage(
                                                notes:
                                                    successState.notes[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit)),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          context.read<NoteBloc>().add(
                                              NoteDeleteEvent(
                                                  noteId: successState
                                                      .notes[index].id!));
                                          context
                                              .read<NoteBloc>()
                                              .add(NoteInitialFetchingEvent());
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                    : const Center(
                        child: Text('No notes found!!'),
                      );

              default:
                return const SizedBox(
                  child: Center(
                    child: Text('Could Not Load!!'),
                  ),
                );
            }
          },
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNotePage()),
                );
              },
              backgroundColor: kBlue,
              shape: const CircleBorder(),
              elevation: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              )),
        ),
      ),
    );
  }
}
