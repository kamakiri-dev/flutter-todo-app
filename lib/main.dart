import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:todo_app/app/router/app_router.dart';
import 'package:todo_app/app/theme/app_theme.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/data/todo_database.dart';
import 'package:todo_app/features/todo/data/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/todo_mapper.dart';
import 'package:todo_app/features/todo/repository/todo_repository.dart';

void main() {
  // Web では sqflite が使えないため、WASM 版の databaseFactory に差し替える
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWebNoWebWorker;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(
        repository: TodoRepository(
          localDataSource: TodoLocalDataSource(
            database: TodoDatabase(),
            mapper: TodoMapper(),
          ),
        ),
      )..add(const TodoLoad()),
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,

        // 中華フォントを修正
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale("ja", "JP")],
      ),
    );
  }
}
