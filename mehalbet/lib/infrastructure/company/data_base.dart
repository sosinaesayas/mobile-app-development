import 'dart:convert';

import 'package:jobportal/domain/company/company_model.dart';
import 'package:jobportal/domain/job/model/job_model.dart';
import 'package:jobportal/domain/user/user_failure.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';

class CompanyDatabase {
  static final CompanyDatabase _instance = CompanyDatabase._init();
  static Database? _database;

  CompanyDatabase._init();

  static CompanyDatabase get getInstance => _instance;

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
    final path = join(dbPath, 'mycompany.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS freelancers(
      id TEXT PRIMARY KEY, 
      firstName TEXT,
      lastName TEXT, 
      email TEXT, 
      phone TEXT, 
      department TEXT, 
      description TEXT,
      acceptance TEXT
    )
  ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS appliedfreelancers(
        jobid TEXT PRIMARY KEY , 
        freelancerid TEXT,
        firstName TEXT,
        lastName TEXT, 
        email TEXT,
        phone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS postedjobs(
        id TEXT PRIMARY KEY,
        title TEXT,
        dateCreated TEXT,
        description TEXT,
        status TEXT,
        companyName TEXT,
        location TEXT,
        deadline TEXT,
        appliedpeople INT,
        phone TEXT

      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS company(
        id TEXT PRIMARY KEY,
        name TEXT,
        email Text,
        token Text
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS connectedfreelancers(
        id TEXT PRIMARY KEY
      )
    ''');


    await db.execute('''
      CREATE TABLE IF NOT EXISTS appliedfreelancers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jobid TEXT,
        freelancers TEXT
      )
    ''');
  }

  Future<void> insertCompany(Company company) async {
    final db = await database;

    await db.insert(
      'company',
      company.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
   Future<void> addPostedJob(Job job) async {
    final db = await database;
 await db.execute('DELETE FROM postedjobs');
    await db.insert(
      'postedjobs',
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addFreelancers(List<UserModel> freelancers) async {
    final db = await database;

    await db.execute('DELETE FROM freelancers');

    Batch batch = db.batch();
    freelancers.forEach((freelancer) {
      batch.insert('freelancers', freelancer.toMap());
    });
    await batch.commit();
  }

  Future<Either<UserFailure, List<UserModel>>> fetchFreelancers() async {
    try {
      final db = await database;

      List<Map<String, dynamic>> results = await db.query('freelancers');

      List<UserModel> freelancers =
          results.map((row) => UserModel.fromMap(row)).toList();

      return right(freelancers);
    } catch (e) {
      return left(DatabaseFailure("Couldn't fetch from the database."));
    }
  }

  Future<Company?> fetchCompany() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query('company', limit: 1);

    if (results.isNotEmpty) {
      return Company.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<void> insertConnectedFreelancer(String id) async {
    final db = await database;

    await db.insert(
      'connectedfreelancers',
      {'id': id},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> checkConnection(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      'connectedfreelancers',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.isNotEmpty;
  }

  Future<void> removeConnection(String id) async {
    final db = await database;

    await db.delete(
      'connectedfreelancers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
   Future<List<Job>> getPostedJobs() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query('postedjobs');

    List<Job> postedJobs = results.map((row) => Job.fromJson(row)).toList();

    return postedJobs;
  }

    Future<void> insertPostedJobs(List<Job> jobs) async {
    final db = await database;

    Batch batch = db.batch();
    jobs.forEach((job) {
      batch.insert('postedjobs', job.toMap());
    });
    await batch.commit();
  }
  Future<void> deletePostedJobsTable() async {
  final db = await database;
  await db.execute('DROP TABLE IF EXISTS postedjobs');
  await _createDB(db, 1);
}

Future<void> updatePostedJobStatus(String id) async {
  final db = await database;
  final List<Map<String, dynamic>> results = await db.query(
    'postedjobs',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (results.isNotEmpty) {
    final job = results.first;
    final String newStatus = (job['status'] == 'Open') ? 'Closed' : 'Open';

    await db.update(
      'postedjobs',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

 Future<void> insertOrUpdateAppliedFreelancers(String jobId, List<UserModel> freelancers) async {
    final db = await database;

    final existingRecord = await db.query(
      'appliedfreelancers',
      where: 'jobid = ?',
      whereArgs: [jobId],
    );

    final freelancersJson = jsonEncode(freelancers.map((user) => user.toMap()).toList());

    if (existingRecord.isNotEmpty) {
      await db.update(
        'appliedfreelancers',
        {'freelancers': freelancersJson},
        where: 'jobid = ?',
        whereArgs: [jobId],
      );
    } else {
      await db.insert(
        'appliedfreelancers',
        {'jobid': jobId, 'freelancers': freelancersJson},
      );
    }
  }

  Future<List<UserModel>> getAppliedFreelancers(String jobId) async {
    final db = await database;

    final result = await db.query(
      'appliedfreelancers',
      where: 'jobid = ?',
      whereArgs: [jobId],
    );

    if (result.isNotEmpty) {
      final freelancersJson = result.first['freelancers'] as String;
      final freelancersList = jsonDecode(freelancersJson) as List<dynamic>;
      final freelancers = freelancersList.map((json) => UserModel.fromJson(json)).toList();
      return freelancers;
    }

    return [];
  }

     Future<Company> getCompany() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('company');

    if (results.isNotEmpty) {
      return Company.fromJson(results.first);
    } else {
      throw Exception('Company not found');
    }
  }

}
