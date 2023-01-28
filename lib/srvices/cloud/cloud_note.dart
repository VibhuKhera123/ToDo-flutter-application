import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

class CloudNote {
  final String doucmentId;
  final String ownerUserId;
  final String text;

  const CloudNote({
    required this.doucmentId,
    required this.ownerUserId,
    required this.text,
  });
  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : doucmentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName];
}
