import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/db/database.dart';
import 'package:logger/logger.dart';
import 'package:project/screens/caatalog.dart';
import 'package:project/screens/edit.dart';
import 'package:project/screens/registry.dart';

final logger = Logger();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;

  MyHomePage({super.key});

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLiteデモ'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //登録
            ElevatedButton(
              onPressed: () {
                _insert();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
              child: const Text(
                '登録',
                style: TextStyle(fontSize: 28),
              ),
            ),
            //照会
            ElevatedButton(
              onPressed: () {
                _query();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
              child: const Text(
                '照会',
                style: TextStyle(fontSize: 28),
              ),
            ),
            //更新
            ElevatedButton(
              onPressed: () {
                _update();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
              child: const Text(
                '更新',
                style: TextStyle(fontSize: 28),
              ),
            ),
            //削除
            ElevatedButton(
              onPressed: () {
                _delete();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogPage()),
                );
              },
              child: const Text(
                '削除',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 登録ボタンクリック
  void _insert() async {
    // row to insert
    const List<String> cat = ['肉.豚', '肉.牛', '魚', '野菜', '果物'];
    Map<String, dynamic> row = {
      DatabaseHelper.columnCategory: cat[Random().nextInt(5)],
      DatabaseHelper.columnName: '豚バラ',
      DatabaseHelper.columnPurchase: '20230214',
      DatabaseHelper.columnLimit: '20230218',
      DatabaseHelper.columnPhotoPath: 'Path/To/Photo.jpg',
      DatabaseHelper.columnMemo: '残り半分',
    };
    final id = await dbHelper.insert(row);
    logger.d('登録しました。id: $id');
  }

  // 照会ボタンクリック
  void _query() async {
    final allRows = await dbHelper.getCategory(); //登録されているカテゴリ一覧を取得
    //final allRows = await dbHelper.where('categoly LIKE \'肉.豚\'');//カテゴリが肉.豚の物を取得
    //final allRows = await dbHelper.where('categoly LIKE \'肉.%\'');//カテゴリが肉の物を取得
    //final allRows = await dbHelper.where('_id = 3');//ID=3を取得
    logger.d('全てのデータを照会しました。');
    logger.d(allRows);
  }

  // 更新ボタンクリック
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1, //更新するデータのID
      DatabaseHelper.columnCategory: '肉.豚',
      DatabaseHelper.columnName: '豚こま切れ',
      DatabaseHelper.columnPurchase: '20230214',
      DatabaseHelper.columnLimit: '20230218',
      DatabaseHelper.columnPhotoPath: 'Path/To/Photo.jpg',
      DatabaseHelper.columnMemo: '残り半分',
    };
    final rowsAffected = await dbHelper.update(row);
    logger.d('更新しました。 ID：$rowsAffected ');
  }

  // 削除ボタンクリック
  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!); //削除するデータのID
    logger.d('削除しました。 $rowsDeleted ID: $id');
  }
}
