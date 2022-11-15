import '../data/model/pump.dart';
import '../data/model/pump.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setPump(Pump Pump);
  Stream<List<Pump>> pumpsStream();
  Stream<Pump> pumpStream({required Pump Pump});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setPump(Pump Pump) => _service.setData(
        path: APIPath.Pump(uid, Pump.id),
        data: Pump.toMap(),
      );

  @override
  Stream<Pump> pumpStream({required Pump Pump}) => _service.documentStream(
        path: APIPath.Pump(uid, Pump.id),
        builder: (data, documentId) => Pump.fromMap(data, documentId),
      );

  @override
  Stream<List<Pump>> pumpsStream() => _service.collectionStream(
        path: APIPath.Pumps(uid),
        builder: (data, documentId) => Pump.fromMap(data, documentId),
      );
}
