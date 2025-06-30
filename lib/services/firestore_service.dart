import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendtrain/models/training_form/training_form_model.dart';
import 'package:sendtrain/models/training_program/training_program.dart';
import 'package:sendtrain/models/user/user_model.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(FirebaseFirestore.instance);
});

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      // TODO: Add proper error handling
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<UserModel?> fetchUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.uid).update(user.toJson());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  Stream<UserModel?> streamUser(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  Stream<List<TrainingProgram>> streamTrainingPlans(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('trainingPlans')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TrainingProgram.fromJson(doc.data()))
              .toList();
        });
  }

  Future<void> submitClimbingForm(
    String userId,
    TrainingFormModel formModel,
  ) async {
    try {
      final docId = formModel.createdAt.toIso8601String();
      await _db
          .collection('users')
          .doc(userId)
          .collection('trainingForms')
          .doc(docId)
          .set(formModel.toJson());
    } catch (e) {
      print('Error submitting climbing form: $e');
      rethrow;
    }
  }

  Future<void> startTrainingPlan(String uid, String planId) async {
    return _db
        .collection('users')
        .doc(uid)
        .collection('training_plans')
        .doc(planId)
        .update({'startedAt': FieldValue.serverTimestamp()});
  }

  Future<void> saveTrainingPlan(
    String uid,
    TrainingProgram trainingProgram,
  ) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('training_plans')
        .doc(trainingProgram.id)
        .set(trainingProgram.toJson());
  }
}
