/// Tests have to be platform specific.
@TestOn("linux")

import 'dart:io';

import 'package:path/path.dart' as path_lib;
import 'package:app_cache/app_cache.dart';
import 'package:app_cache/src/locator.dart';
import 'package:test/test.dart';

void main() {
  test('Test Locator for Linux', () {
    // Ask for the path using our Locator API (that we are testing against).
    final path = Locator.getPlatformSpecificCachePath();
    // First, figure out correct user for Windows.
    final user = Platform.environment['HOME'];
    // Create the path that we know is correct.
    final correct_path = path_lib.join('home', user);

    // The paths MUST match, otherwise an error occured somewhere.
    expect(path, correct_path);
  });

  test('Test AppCache Verify Correct Path on Linux', () {
    // Create the app cache.
    final testCache = AppCache.findOrCreate('test_app');
    // Now, figure out correct user for Windows.
    final user = Platform.environment['HOME'];
    // Create the path that we know is correct.
    final correct_path = path_lib.join('home', user, 'test_app');
    
    // Create a directory using this path, and make sure it exists.
    expect(testCache.path, correct_path);
  });

  test('Test AppCache Creation on Linux', () {
    // Create the app cache.
    final testCache = AppCache.findOrCreate('test_app');
    // Now, figure out correct user for Windows.
    final user = Platform.environment['HOME'];
    // Create the path that we know is correct.
    final correct_path = path_lib.join('home', user, 'test_app');
    
    // Create a directory using this path, and make sure it exists.
    expect(Directory(correct_path).existsSync(), true);
  });

  test('Test AppCache Deletion on Linux', () {
    // Create the app cache.
    final testCache = AppCache.findOrCreate('test_app');
    // Now, delete the cache.
    testCache.delete();
    // Now, figure out correct user for Windows.
    final user = Platform.environment['HOME'];
    // Create the path that we know is correct.
    final correct_path = path_lib.join('home', user, 'test_app');

    // Apparently deletion happens too quickly for the test to register,
    // so we have to sleep.
    sleep(const Duration(seconds:2));
    // Check that it does NOT exist anymore.
    expect(Directory(correct_path).existsSync(), false);
  });
}
