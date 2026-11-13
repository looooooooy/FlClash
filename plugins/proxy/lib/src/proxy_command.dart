import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

const proxyHost = '127.0.0.1';

typedef ProxyProcessRunner =
    Future<ProcessResult> Function(
      String executable,
      List<String> arguments, {
      bool runInShell,
    });

typedef ProxyExecutableChecker = Future<bool> Function(String executable);

@immutable
class ProxyCommand {
  final String executable;
  final List<String> args;
  final bool runInShell;
  final bool optional;

  ProxyCommand(
    this.executable,
    List<String> args, {
    this.runInShell = false,
    this.optional = false,
  }) : args = List.unmodifiable(args);
}

class ProxyCommandRunner {
  static const _commandTimeout = Duration(seconds: 8);
  final ProxyProcessRunner? _processRunner;

  ProxyCommandRunner([this._processRunner]);

  Future<ProcessResult> process(
    String executable,
    List<String> arguments, {
    bool runInShell = false,
  }) {
    final processRunner = _processRunner;
    if (processRunner != null) {
      return processRunner(
        executable,
        arguments,
        runInShell: runInShell,
      ).timeout(_commandTimeout);
    }
    return _runWithTimeout(executable, arguments, runInShell: runInShell);
  }

  Future<ProcessResult> _runWithTimeout(
    String executable,
    List<String> arguments, {
    bool runInShell = false,
  }) async {
    final process = await Process.start(
      executable,
      arguments,
      runInShell: runInShell,
    );
    await process.stdin.close();
    final stdout = utf8.decoder.bind(process.stdout).join();
    final stderr = utf8.decoder.bind(process.stderr).join();
    try {
      final result = await Future.wait<dynamic>([
        stdout,
        stderr,
        process.exitCode,
      ]).timeout(_commandTimeout);
      return ProcessResult(process.pid, result[2] as int, result[0], result[1]);
    } on TimeoutException {
      process.kill();
      final exitCode = await process.exitCode.timeout(
        const Duration(seconds: 1),
        onTimeout: () => -1,
      );
      final output = await stdout.timeout(
        const Duration(seconds: 1),
        onTimeout: () => '',
      );
      final error = await stderr.timeout(
        const Duration(seconds: 1),
        onTimeout: () => '',
      );
      return ProcessResult(
        process.pid,
        exitCode == 0 ? -1 : exitCode,
        output,
        error,
      );
    }
  }

  Future<bool> run(Iterable<ProxyCommand> commands) async {
    var executed = false;
    for (final command in commands) {
      executed = true;
      if (!await _succeeds(command) && !command.optional) {
        return false;
      }
    }
    return executed;
  }

  Future<bool> _succeeds(ProxyCommand command) async {
    try {
      final result = await process(
        command.executable,
        command.args,
        runInShell: command.runInShell,
      );
      return result.exitCode == 0;
    } on ProcessException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
