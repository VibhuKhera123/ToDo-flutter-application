// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';
import 'package:todo_app/srvices/auth/bloc/auth_bloc.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';
import 'package:todo_app/srvices/cloud/cloud_note.dart';
import 'package:todo_app/srvices/cloud/firebase_cloud_storage.dart';
import 'package:todo_app/srvices/crud/notes_services.dart';
import 'package:todo_app/utilities/dialog/logout_dialog.dart';
import 'package:todo_app/views/notesView/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  @override
  void initState() {
    _notesService = FirebaseCloudStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes View"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createUpdateNote);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              final shouldlogout = await showLogOutDialog(context);
              if (shouldlogout) {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.doucmentId);
                  },
                  onTap: (note) async {
                    Navigator.of(context).pushNamed(
                      createUpdateNote,
                      arguments: note,
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
