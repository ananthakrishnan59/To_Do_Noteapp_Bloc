part of'note_bloc.dart';

@immutable
sealed class NoteState {}

sealed class NoteActionState extends NoteState {}

final class NoteInitial extends NoteState {}

class NoteFetchingLoadingState extends NoteState {}

class NoteFetchingSucessState extends NoteState {
  final List<NoteModel> notes;
  NoteFetchingSucessState({required this.notes});
}

class NoteFetchingErrorState extends NoteState{}



class NoteAddSucessActionState extends NoteActionState{}
class NoteDeleteSuccessActionState extends NoteActionState {}
class NoteUpdateSucessActionState extends NoteActionState{}

class NoteAddErrorActionState extends NoteActionState {}
class NoteDeleteErrorActionState extends NoteActionState {}
class NoteUpdateErrorActionState extends NoteActionState{}