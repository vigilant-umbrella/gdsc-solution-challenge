import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // creating the user document
  Future<void> getOrCreateUser() async {
    final user = AuthService().user;

    if (user == null) return;

    final userRef = _firestore.collection('users').doc(user.uid);
    final userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      final data = <String, dynamic>{
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'user',
      };
      await userRef.set(data);
    }
  }
}
