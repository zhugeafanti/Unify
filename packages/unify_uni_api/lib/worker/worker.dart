import 'dart:io';

import 'package:unify_flutter/analyzer/analyzer_lib.dart';
import 'package:unify_flutter/cli/commands/generate_api_command.dart';
import 'package:unify_flutter/worker/check_duplicate.dart';
import 'package:unify_flutter/worker/clean_outdated.dart';
import 'package:unify_flutter/utils/file/file.dart';
import 'package:unify_flutter/utils/log.dart';
import 'package:unify_flutter/worker/work_runner.dart';

Future<int> isolateRun(List<String> args) async {
  log('isolateRun', value: args);

  final options = args.toOptions();
  final tempDir = Directory(options.tempDir);
  final files = await parseInputFiles(options.projectPath, tempDir.path);

  final analyzer = UniApiAnalyzer(files)..parseFile(options.projectPath);
  final results = analyzer.results();
  final uniModelASTs = results.models;
  final uniNativeModuleASTs = results.nativeModules;
  final uniFlutterModuleAst = results.flutterModules;

  // Detect if there are duplicate named classes in the template
  checkDuplicateSymbol(results);
  await cleanOutdatedUniApiFiles(options, tempDir.path, results);

  // Generate UniModel
  for (final model in uniModelASTs) {
    final runner = UniModelWorkRunner(model, options);
    runner.dartGenerator();
    runner.javaGenerator();
    runner.objcGenerator();
  }

  // Generate UniNativeModules
  for (final module in uniNativeModuleASTs) {
    final runner = UniNativeModuleWorkRunner(module, options);
    runner.dartGenerator();
    runner.javaGenerator();
    runner.objcGenerator();
  }

  // Generate UniAPI class
  final uniAPIRunner = UniAPIWorkRunner(options: options, models: uniModelASTs);
  uniAPIRunner.dartGenerator();
  uniAPIRunner.javaGenerator();
  uniAPIRunner.objcGenerator();

  // Generate UniFlutterModules
  for (final module in uniFlutterModuleAst) {
    final runner = UniFlutterModuleWorkRunner(module, options);
    runner.dartGenerator();
    runner.javaGenerator();
    runner.objcGenerator();
  }

  // Generate UniCallback Dispatcher
  final callbackDispatcherRunner = CallbackDispatcherWorkRunner(options: options);
  callbackDispatcherRunner.javaGenerator();
  callbackDispatcherRunner.objcGenerator();

  printf(r'Finished. \(≧▽≦)/');

  return 0;
}
