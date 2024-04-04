import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_note_bloc/Domain/note_repo.dart';
import 'package:to_do_note_bloc/Model/note_model.dart';
part 'note_event.dart';
part 'note_state.dart';
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<NoteInitialFetchingEvent>(noteInitialFetchingEvent);
    on<NoteAddEvent>(noteAddEvent);
    on<NoteDeleteEvent>(noteDeleteEvent);
    on<NoteUpdateEvent>(noteUpdateEvent);
  }
  FutureOr<void> noteInitialFetchingEvent(
      NoteInitialFetchingEvent event, Emitter<NoteState> emit) async {
    emit(NoteFetchingLoadingState());
    List<NoteModel> notes = await NoteRepo.fetchNotes();
    emit(NoteFetchingSucessState(notes: notes));
  }

  FutureOr<void> noteAddEvent(
      NoteAddEvent event, Emitter<NoteState> emit) async {
    bool success = await NoteRepo.addNote(note: event.note);
    debugPrint('$success');
    if (success) {
      emit(NoteAddSucessActionState());
    } else {
      emit(NoteAddErrorActionState());
    }
  }

  FutureOr<void> noteDeleteEvent(
      NoteDeleteEvent event, Emitter<NoteState> emit) async {
    bool sucess = await NoteRepo.deleteNote(noteId: event.noteId);
    debugPrint('$sucess');
    if (sucess) {
      emit(NoteDeleteSuccessActionState());
    } else {
      emit(NoteDeleteErrorActionState());
    }
  }

  FutureOr<void> noteUpdateEvent(
      NoteUpdateEvent event, Emitter<NoteState> emit) async {
    bool success = await NoteRepo.updateNote(note: event.note);
    debugPrint('$success');
    if (success) {
      emit(NoteUpdateSucessActionState());
    } else {
      emit(NoteUpdateErrorActionState());
    }
  }
}
