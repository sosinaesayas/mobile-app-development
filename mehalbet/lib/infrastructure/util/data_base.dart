import 'package:jobportal/domain/notification/model/notifications.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:jobportal/domain/job/model/job_model.dart';


class MehalbetDatabase {
  static final MehalbetDatabase _instance = MehalbetDatabase._init();
  static  Database? _database; 

  MehalbetDatabase._init();
 
 static MehalbetDatabase get getInstance => _instance;
 Future<Database> get database async {
  if (_database != null && _database!.isOpen) {
    return _database!;
  } else {
    _database = await _initDB();
    return _database!;
  }
}


  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mydatabase.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS jobs(
        id TEXT PRIMARY KEY,
        title TEXT,
        dateCreated TEXT,
        description TEXT,
        status TEXT,
        companyName TEXT,
        location Text,
        deadline Text,
        appliedpeople TEXT
      )
    ''');

   await db.execute('''
    CREATE TABLE IF NOT EXISTS user(
        id TEXT PRIMARY KEY, 
        firstName TEXT,
        lastName TEXT, 
        token TEXT, 
        phone TEXT, 
        department TEXT,
        description TEXT,
        email TEXT,
        acceptance TEXT
       

    )
''');

     await db.execute('''
      CREATE TABLE IF NOT EXISTS myjobs(
        id TEXT PRIMARY KEY,
        title TEXT,
        dateCreated TEXT,
        description TEXT,
        status TEXT,
        companyName TEXT,
        location Text,
        deadline Text,
        appliedpeople TEXT
      )
    ''');

         await db.execute('''
    CREATE TABLE IF NOT EXISTS user_notifications(
      message TEXT,
      companyName TEXT,
      unread INTEGER
    )
  ''');


   await db.execute('''
      CREATE TABLE IF NOT EXISTS appliedjobs(
        id TEXT PRIMARY KEY
      )
    ''');
  }

  // Jobs Table
  Future<void> removeUser() async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS user');
  }
  Future<void> insertJob(Job job , String tableName) async {
    final db = await database;
    await db.insert(
      '$tableName',
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mehalbet.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  Future<List<Job>> getAllJobs(table) async {
    final db = await database;
    final maps = await db.query('$table');
    return List.generate(maps.length, (i) {
      return Job(
        id: maps[i]['id'] as String,
        title: maps[i]['title'] as String,
        dateCreated: maps[i]['dateCreated'] as String,
        description: maps[i]['description'] as String,
        status: maps[i]['status'] as String,
        companyName: maps[i]['companyName'] as String,
        location: maps[i]['location'] as String,
        deadline : maps[i]['deadline'] as String
      );
    });
  }

  // user Table
Future<void> _createUserTable(Database db) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS user(
      id TEXT PRIMARY KEY, 
      firstName TEXT,
      lastName TEXT, 
      token TEXT, 
      phone TEXT, 
      department TEXT,
      description TEXT,
      email TEXT,
      acceptance TEXT
    )
  ''');
}

  Future<void> insertUser(UserModel user) async {
  final db = await database;
  final bool userTableExists = await _checkUserTableExists(db);

  if (!userTableExists) {
    await _createUserTable(db);
  }

  await db.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


Future<bool> _checkUserTableExists(Database db) async {
  final List<String> tables = await db
      .query('sqlite_master', where: 'type = ?', whereArgs: ['table'])
      .then((value) => List<String>.from(value.map((e) => e['name'] as String)));

  return tables.contains('user');
}


  Future<UserModel?> getUser() async {
  final db = await database;
  final maps = await db.query('user');
  if (maps.isNotEmpty) {
    return UserModel(
      // token: maps.first['token'] as String,
      firstName: maps.first['firstName'] as String,
      lastName: maps.first['lastName'] as String,
      email: maps.first['email'] as String,
      id: maps.first['id'] as String,
      phone : maps.first['phone'] as String,
      department: maps.first["department"] as String, 
      description: maps.first['description'] as String, 
      // experience: maps.first['experience'] as String
      // phone: maps.first['phone'] as String
    );
  }
  return null;
}



   Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'job.db');
    await deleteDatabase();
    _database = null; // Reset the database instance after deletion
  }
  Future<void> deleteUserTable() async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS user');
  }





  Future<void> insertJobs({required List<Job> jobs ,required String tableName}) async {
    final db = await database;
    final batch = db.batch();

    for (final job in jobs) {
      batch.insert(
        '$tableName',
        job.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
    await _deleteExcessJobs(db , tableName);
  }

  Future<void> _deleteExcessJobs(Database db , String tableName) async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM jobs'),
    );

    if (count! > 20) {
      final oldestJobs = await db.rawQuery(
        'SELECT id FROM ${tableName} ORDER BY dateCreated ASC LIMIT ?',
        [count - 20],
      );

      final ids = oldestJobs.map((job) => job['id'] as String).toList();

      await db.delete(
        '${tableName}',
        where: 'id IN (${List.filled(ids.length, '?').join(', ')})',
        whereArgs: ids,
      );
    }
  }


Future<void> insertUserNotifications(List<UserNotification> notifications) async {
  final db = await database;
  final batch = db.batch();

 

  for (final notification in notifications) {
    final doesNotificationExist =
        await checkNotificationExistence(notification.message, notification.companyName);
    if (!doesNotificationExist) {
      batch.insert(
        'user_notifications',
        notification.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  await batch.commit();
  await _deleteExcessNotifications(db);
}




Future<bool> checkNotificationExistence(String message, String companyName) async {
  final db = await database;
  final result = await db.rawQuery('''
    SELECT COUNT(*) FROM user_notifications
    WHERE message = ? AND companyName = ?
  ''', [message, companyName]);

  return Sqflite.firstIntValue(result)! > 0;
}



Future<void> _deleteExcessNotifications(Database db) async {
  final count = Sqflite.firstIntValue(
    await db.rawQuery('SELECT COUNT(*) FROM user_notifications'),
  );

  if (count! > 20) {
    final oldestNotifications = await db.rawQuery(
      'SELECT id FROM user_notifications ORDER BY dateCreated ASC LIMIT ?',
      [count - 20],
    );

    final ids = oldestNotifications.map((notification) => notification['id'] as int).toList();

    await db.delete(
      'user_notifications',
      where: 'id IN (${List.filled(ids.length, '?').join(', ')})',
      whereArgs: ids,
    );
  }
}


 Future<List<UserNotification>> getUserNotifications() async {
    final db = await database;
    final maps = await db.query('user_notifications');
    return List.generate(maps.length, (i) {
      return UserNotification(
     
        message: maps[i]['message'] as String,
        companyName: maps[i]['companyName'] as String,
        unread: maps[i]['unread'] as int == 1,
      );
    });
  }

 Future<bool> isJobApplied(String jobId) async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM appliedjobs WHERE id = ?', [jobId]),
    );
    return count != null && count > 0;
  }

  Future<void> applyJob(String jobId) async {
    final db = await database;
    await db.insert(
      'appliedjobs',
      {'id': jobId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeJobApplication(String jobId) async {
    final db = await database;
    await db.delete(
      'appliedjobs',
      where: 'id = ?',
      whereArgs: [jobId],
    );
  }



  Future<void> insertAppliedJobs(List<Job> appliedjobs) async {
    final db = await database;
    final batch = db.batch();

    for (final job in appliedjobs) {
      batch.insert(
        'myjobs',
        job.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();}


}