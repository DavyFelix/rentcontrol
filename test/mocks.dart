import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

// Mocks básicos para FirebaseFirestore e subcoleções/documentos

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}
