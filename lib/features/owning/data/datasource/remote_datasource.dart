import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/owning_model.dart';

abstract class OwningBaseRemoteDataSource {
  Future<List<OwningModel>> getOwning();
  Future<Either<Failure, Unit>> add({required String title});
  Future<Either<Failure, Unit>> update({required OwningModel model});
  Future<Either<Failure, Unit>> deleteAll();
  Future<Either<Failure, Unit>> deleteItem({required String id});
}

class OwningRemoteDataSource implements OwningBaseRemoteDataSource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<List<OwningModel>> getOwning() async {
    final DocumentSnapshot _mainCollection =
        await _fireStore.collection('constants').doc('owning').get();

    var list = List<OwningModel>.from((_mainCollection.get('data'))
        .map((e) => OwningModel.fromJson(e)));
    return list.reversed.toList();
  }

  @override
  Future<Either<Failure, Unit>> add({required String title}) async {
    final DocumentReference _mainCollection =
        _fireStore.collection('constants').doc('owning');

    Map<String, dynamic> data = <String, dynamic>{
      "id": DateTime.now().millisecondsSinceEpoch,
      "title": title,
    };

    try {
      await _mainCollection.set({
        'data': FieldValue.arrayUnion([data])
      }, SetOptions(merge: true));
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(mess: e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> update(
      {required OwningModel model}) async {
    final DocumentReference _mainCollection =
        _fireStore.collection('constants').doc('owning');

    var list = await getOwning();

    var reversedList = list.reversed.toList();

    var item = reversedList.firstWhere((element) => element.id == model.id);

    int index = reversedList.indexOf(item);

    reversedList.remove(item);
    reversedList.insert(index, model);

    await deleteAll();

    try {
      for (item in reversedList) {
        await _mainCollection.set({
          'data': FieldValue.arrayUnion([item.toJson()])
        }, SetOptions(merge: true));
      }

      return Right(unit);
    } catch (e) {
      print('e => $e');
      return Left(UnAuthFailure(mess: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAll() async {
    final DocumentReference _mainCollection =
        _fireStore.collection('constants').doc('owning');

    try {
      await _mainCollection.delete();
      await _mainCollection
          .set({'data': FieldValue.arrayUnion([])}, SetOptions(merge: true));
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(mess: e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItem({required String id}) async {
    final DocumentReference _mainCollection =
        _fireStore.collection('constants').doc('owning');

    var list = await getOwning();

    var reversedList = list.reversed.toList();

    var item =
        reversedList.firstWhere((element) => element.id.toString() == id);

    reversedList.remove(item);

    await deleteAll();

    try {
      for (item in reversedList) {
        await _mainCollection.set({
          'data': FieldValue.arrayUnion([item.toJson()])
        }, SetOptions(merge: true));
      }

      return Right(unit);
    } catch (e) {
      return Left(UnAuthFailure(mess: e.toString()));
    }
  }
}
