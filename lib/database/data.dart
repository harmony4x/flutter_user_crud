
import 'package:drift/drift.dart';

part 'data.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  Column<Uint8List> get image => blob().nullable()();

}

abstract class UsersView extends View {
  Users get users;

  @override
  Query as() => select([
    users.id,
    users.email,
    users.name,
    users.password,
    users.image,
  ]).from(users);
}

@DriftDatabase(tables:[
  Users
], views: [
  UsersView
])

class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
