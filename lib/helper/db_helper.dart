// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../data/models/meal_plan.dart';
//
// class DBHelper {
//   static Database? _db;
//
//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB();
//     return _db!;
//   }
//
//   static Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), 'mealplan.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE mealPlans(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             mealType TEXT,
//             food TEXT,
//             preference TEXT,
//             quantity TEXT,
//             unit TEXT,
//             brand TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   static Future<int> insertMeal(MealPlan meal) async {
//     final db = await database;
//     return await db.insert('mealPlans', meal.toMap());
//   }
//
//   static Future<List<MealPlan>> fetchMeals() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('mealPlans');
//     return List.generate(maps.length, (i) => MealPlan.fromMap(maps[i]));
//   }
//
//   static Future<int> updateMeal(MealPlan meal) async {
//     final db = await database;
//     return await db.update(
//       'mealPlans',
//       meal.toMap(),
//       where: 'id = ?',
//       whereArgs: [meal.id],
//     );
//   }
//
//   static Future<int> deleteMeal(int id) async {
//     final db = await database;
//     return await db.delete(
//       'mealPlans',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   static Future<void> clearMeals() async {
//     final db = await database;
//     await db.delete('mealPlans');
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/models/meal_plan.dart';

class DBHelper {
  static Database? _db;

  // Getter for database instance
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  // Initialize the database
  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'mealplan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Table: months
        await db.execute('''
          CREATE TABLE months (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');

        // Table: weeks
        await db.execute('''
          CREATE TABLE weeks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            month_id INTEGER,
            name TEXT NOT NULL,
            FOREIGN KEY (month_id) REFERENCES months(id) ON DELETE CASCADE
          )
        ''');

        // Table: days
        await db.execute('''
          CREATE TABLE days (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            week_id INTEGER,
            name TEXT NOT NULL,
            FOREIGN KEY (week_id) REFERENCES weeks(id) ON DELETE CASCADE
          )
        ''');

        // Table: meals
        await db.execute('''
          CREATE TABLE meals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day_id INTEGER,
            mealType TEXT NOT NULL,
            food TEXT NOT NULL,
            preference TEXT,
            quantity TEXT,
            unit TEXT,
            brand TEXT,
            FOREIGN KEY (day_id) REFERENCES days(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // ===============================
  // INSERT FUNCTIONS
  // ===============================

  static Future<int> insertMonth(String name) async {
    final db = await database;
    return await db.insert('months', {'name': name});
  }

  static Future<int> insertWeek(int monthId, String name) async {
    final db = await database;
    return await db.insert('weeks', {
      'month_id': monthId,
      'name': name,
    });
  }

  static Future<int> insertDay(int weekId, String name) async {
    final db = await database;
    return await db.insert('days', {
      'week_id': weekId,
      'name': name,
    });
  }

  static Future<int> insertMeal(int dayId, MealPlan meal) async {
    final db = await database;
    return await db.insert('meals', {
      'day_id': dayId,
      'mealType': meal.mealType,
      'food': meal.food,
      'preference': meal.preference,
      'quantity': meal.quantity,
      'unit': meal.unit,
      'brand': meal.brand,
    });
  }

  // ===============================
  // FETCH FUNCTIONS
  // ===============================

  static Future<List<Map<String, dynamic>>> fetchMonths() async {
    final db = await database;
    return await db.query('months');
  }

  static Future<List<Map<String, dynamic>>> fetchWeeks(int monthId) async {
    final db = await database;
    return await db.query('weeks', where: 'month_id = ?', whereArgs: [monthId]);
  }

  static Future<List<Map<String, dynamic>>> fetchDays(int weekId) async {
    final db = await database;
    return await db.query('days', where: 'week_id = ?', whereArgs: [weekId]);
  }

  static Future<List<MealPlan>> fetchMealsByDay(int dayId) async {
    final db = await database;
    final result = await db.query('meals', where: 'day_id = ?', whereArgs: [dayId]);
    return result.map((map) => MealPlan.fromMap(map)).toList();
  }

  // ===============================
  // UPDATE / DELETE
  // ===============================

  static Future<int> updateMeal(MealPlan meal) async {
    final db = await database;
    return await db.update(
      'meals',
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  static Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(
      'meals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> clearAllData() async {
    final db = await database;
    await db.delete('meals');
    await db.delete('days');
    await db.delete('weeks');
    await db.delete('months');
  }
}
