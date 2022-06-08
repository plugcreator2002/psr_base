import 'package:hive/hive.dart';

class HiveSyncAdapter<T> {
  final TypeAdapter<T> adapter;
  final String name;

  const HiveSyncAdapter(this.adapter, this.name);
}
