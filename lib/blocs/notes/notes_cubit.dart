import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/note_model.dart';
import '../../repositories/notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository _notesRepository;
  final String userId;

  NotesCubit(this._notesRepository, this.userId) : super(NotesInitial()) {
    fetchNotes();
  }

  void fetchNotes() {
    emit(NotesLoading());
    _notesRepository.getNotes(userId).listen(
      (notes) => emit(NotesLoaded(notes)),
      onError: (error) {
        emit(NotesError("Failed to load notes: $error"));
      },
    );
  }

  Future<void> addNote(Note note) async {
    try {
      await _notesRepository.addNote(note);
    } catch (e) {
      emit(NotesError("Failed to add note: ${e.toString()}"));
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _notesRepository.updateNote(note);
    } catch (e) {
      emit(NotesError("Failed to update note: ${e.toString()}"));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesRepository.deleteNote(noteId);
    } catch (e) {
      emit(NotesError("Failed to delete note: ${e.toString()}"));
    }
  }
}
