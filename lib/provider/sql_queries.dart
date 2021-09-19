class Queries {
  String createCacheTable = '''
    CREATE TABLE IF NOT EXISTS cache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      body TEXT
      );
      ''';
  String dropCacheTable = 'DROP TABLE cache';
}
