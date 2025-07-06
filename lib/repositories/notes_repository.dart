import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore;

  NotesRepository(this._firestore);

  /// 🔄 Realtime stream of notes for a specific user, sorted by newest first
  Stream<List<Note>> getNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromMap(doc.data(), doc.id)).toList());
  }

  /// ➕ Add a new note to Firestore
  Future<void> addNote(Note note) async {
    try {
      await _firestore.collection('notes').add(note.toMap());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  /// ✏️ Update an existing note by ID
  Future<void> updateNote(Note note) async {
    try {
      await _firestore.collection('notes').doc(note.id).update(note.toMap());
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  /// 🗑 Delete a note by ID
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}
