import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_note_bloc/Model/note_model.dart';

const String baseUrl = 'https://api.nstack.in/v1/todos';

class NoteRepo {
  static Future<List<NoteModel>> fetchNotes() async {
    var client = http.Client();
    List<NoteModel> notes = [];
    try {
      var response = await client.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List items = responseData['items'];
        for (int i = 0; i < items.length; i++) {
          NoteModel note = NoteModel.fromJson(items[i] as Map<String, dynamic>);
          notes.add(note);
        }
      }
      return notes;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<bool> addNote({required NoteModel note}) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse(baseUrl),
          body: jsonEncode(note),
          headers: {'Content-Type': 'application/json'});
      debugPrint('status code:${response.statusCode}');
      debugPrint(response.body);
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteNote({required String noteId}) async {
    var client = http.Client();
    try {
      String url = "$baseUrl/$noteId";
      debugPrint(url);
      var response = await client.delete(Uri.parse(url));
      debugPrint('status code:${response.statusCode}');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> updateNote({required NoteModel note}) async {
    var client = http.Client();
    try {
      String url = "$baseUrl/${note.id}";
      debugPrint(url);
      var response = await client.put(Uri.parse(url),
          body: jsonEncode(note),
          headers: {'content-Type': 'application/json'});
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
