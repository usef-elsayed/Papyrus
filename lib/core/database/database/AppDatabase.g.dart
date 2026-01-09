// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// ignore_for_file: type=lint
class $BooksTableTable extends BooksTable
    with TableInfo<$BooksTableTable, BooksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta(
    'totalPages',
  );
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPageMeta = const VerificationMeta(
    'currentPage',
  );
  @override
  late final GeneratedColumn<int> currentPage = GeneratedColumn<int>(
    'current_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BookStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(BookStatus.unread.index),
      ).withConverter<BookStatus>($BooksTableTable.$converterstatus);
  static const VerificationMeta _lastAccessMeta = const VerificationMeta(
    'lastAccess',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccess = GeneratedColumn<DateTime>(
    'last_access',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookCfiMeta = const VerificationMeta(
    'bookCfi',
  );
  @override
  late final GeneratedColumn<String> bookCfi = GeneratedColumn<String>(
    'book_cfi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    path,
    title,
    coverPath,
    totalPages,
    currentPage,
    status,
    lastAccess,
    bookCfi,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BooksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    } else if (isInserting) {
      context.missing(_coverPathMeta);
    }
    if (data.containsKey('total_pages')) {
      context.handle(
        _totalPagesMeta,
        totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPagesMeta);
    }
    if (data.containsKey('current_page')) {
      context.handle(
        _currentPageMeta,
        currentPage.isAcceptableOrUnknown(
          data['current_page']!,
          _currentPageMeta,
        ),
      );
    }
    if (data.containsKey('last_access')) {
      context.handle(
        _lastAccessMeta,
        lastAccess.isAcceptableOrUnknown(data['last_access']!, _lastAccessMeta),
      );
    }
    if (data.containsKey('book_cfi')) {
      context.handle(
        _bookCfiMeta,
        bookCfi.isAcceptableOrUnknown(data['book_cfi']!, _bookCfiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BooksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BooksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      )!,
      totalPages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pages'],
      )!,
      currentPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_page'],
      )!,
      status: $BooksTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      lastAccess: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_access'],
      ),
      bookCfi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_cfi'],
      ),
    );
  }

  @override
  $BooksTableTable createAlias(String alias) {
    return $BooksTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BookStatus, int, int> $converterstatus =
      const EnumIndexConverter<BookStatus>(BookStatus.values);
}

class BooksTableData extends DataClass implements Insertable<BooksTableData> {
  final int id;
  final String path;
  final String title;
  final String coverPath;
  final int totalPages;
  final int currentPage;
  final BookStatus status;
  final DateTime? lastAccess;
  final String? bookCfi;
  const BooksTableData({
    required this.id,
    required this.path,
    required this.title,
    required this.coverPath,
    required this.totalPages,
    required this.currentPage,
    required this.status,
    this.lastAccess,
    this.bookCfi,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    map['title'] = Variable<String>(title);
    map['cover_path'] = Variable<String>(coverPath);
    map['total_pages'] = Variable<int>(totalPages);
    map['current_page'] = Variable<int>(currentPage);
    {
      map['status'] = Variable<int>(
        $BooksTableTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || lastAccess != null) {
      map['last_access'] = Variable<DateTime>(lastAccess);
    }
    if (!nullToAbsent || bookCfi != null) {
      map['book_cfi'] = Variable<String>(bookCfi);
    }
    return map;
  }

  BooksTableCompanion toCompanion(bool nullToAbsent) {
    return BooksTableCompanion(
      id: Value(id),
      path: Value(path),
      title: Value(title),
      coverPath: Value(coverPath),
      totalPages: Value(totalPages),
      currentPage: Value(currentPage),
      status: Value(status),
      lastAccess: lastAccess == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccess),
      bookCfi: bookCfi == null && nullToAbsent
          ? const Value.absent()
          : Value(bookCfi),
    );
  }

  factory BooksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BooksTableData(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      title: serializer.fromJson<String>(json['title']),
      coverPath: serializer.fromJson<String>(json['coverPath']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      currentPage: serializer.fromJson<int>(json['currentPage']),
      status: $BooksTableTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      lastAccess: serializer.fromJson<DateTime?>(json['lastAccess']),
      bookCfi: serializer.fromJson<String?>(json['bookCfi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'title': serializer.toJson<String>(title),
      'coverPath': serializer.toJson<String>(coverPath),
      'totalPages': serializer.toJson<int>(totalPages),
      'currentPage': serializer.toJson<int>(currentPage),
      'status': serializer.toJson<int>(
        $BooksTableTable.$converterstatus.toJson(status),
      ),
      'lastAccess': serializer.toJson<DateTime?>(lastAccess),
      'bookCfi': serializer.toJson<String?>(bookCfi),
    };
  }

  BooksTableData copyWith({
    int? id,
    String? path,
    String? title,
    String? coverPath,
    int? totalPages,
    int? currentPage,
    BookStatus? status,
    Value<DateTime?> lastAccess = const Value.absent(),
    Value<String?> bookCfi = const Value.absent(),
  }) => BooksTableData(
    id: id ?? this.id,
    path: path ?? this.path,
    title: title ?? this.title,
    coverPath: coverPath ?? this.coverPath,
    totalPages: totalPages ?? this.totalPages,
    currentPage: currentPage ?? this.currentPage,
    status: status ?? this.status,
    lastAccess: lastAccess.present ? lastAccess.value : this.lastAccess,
    bookCfi: bookCfi.present ? bookCfi.value : this.bookCfi,
  );
  BooksTableData copyWithCompanion(BooksTableCompanion data) {
    return BooksTableData(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      title: data.title.present ? data.title.value : this.title,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      totalPages: data.totalPages.present
          ? data.totalPages.value
          : this.totalPages,
      currentPage: data.currentPage.present
          ? data.currentPage.value
          : this.currentPage,
      status: data.status.present ? data.status.value : this.status,
      lastAccess: data.lastAccess.present
          ? data.lastAccess.value
          : this.lastAccess,
      bookCfi: data.bookCfi.present ? data.bookCfi.value : this.bookCfi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BooksTableData(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('coverPath: $coverPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPage: $currentPage, ')
          ..write('status: $status, ')
          ..write('lastAccess: $lastAccess, ')
          ..write('bookCfi: $bookCfi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    path,
    title,
    coverPath,
    totalPages,
    currentPage,
    status,
    lastAccess,
    bookCfi,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BooksTableData &&
          other.id == this.id &&
          other.path == this.path &&
          other.title == this.title &&
          other.coverPath == this.coverPath &&
          other.totalPages == this.totalPages &&
          other.currentPage == this.currentPage &&
          other.status == this.status &&
          other.lastAccess == this.lastAccess &&
          other.bookCfi == this.bookCfi);
}

class BooksTableCompanion extends UpdateCompanion<BooksTableData> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> title;
  final Value<String> coverPath;
  final Value<int> totalPages;
  final Value<int> currentPage;
  final Value<BookStatus> status;
  final Value<DateTime?> lastAccess;
  final Value<String?> bookCfi;
  const BooksTableCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.title = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPage = const Value.absent(),
    this.status = const Value.absent(),
    this.lastAccess = const Value.absent(),
    this.bookCfi = const Value.absent(),
  });
  BooksTableCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    required String title,
    required String coverPath,
    required int totalPages,
    this.currentPage = const Value.absent(),
    this.status = const Value.absent(),
    this.lastAccess = const Value.absent(),
    this.bookCfi = const Value.absent(),
  }) : path = Value(path),
       title = Value(title),
       coverPath = Value(coverPath),
       totalPages = Value(totalPages);
  static Insertable<BooksTableData> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? title,
    Expression<String>? coverPath,
    Expression<int>? totalPages,
    Expression<int>? currentPage,
    Expression<int>? status,
    Expression<DateTime>? lastAccess,
    Expression<String>? bookCfi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (title != null) 'title': title,
      if (coverPath != null) 'cover_path': coverPath,
      if (totalPages != null) 'total_pages': totalPages,
      if (currentPage != null) 'current_page': currentPage,
      if (status != null) 'status': status,
      if (lastAccess != null) 'last_access': lastAccess,
      if (bookCfi != null) 'book_cfi': bookCfi,
    });
  }

  BooksTableCompanion copyWith({
    Value<int>? id,
    Value<String>? path,
    Value<String>? title,
    Value<String>? coverPath,
    Value<int>? totalPages,
    Value<int>? currentPage,
    Value<BookStatus>? status,
    Value<DateTime?>? lastAccess,
    Value<String?>? bookCfi,
  }) {
    return BooksTableCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      title: title ?? this.title,
      coverPath: coverPath ?? this.coverPath,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
      lastAccess: lastAccess ?? this.lastAccess,
      bookCfi: bookCfi ?? this.bookCfi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (currentPage.present) {
      map['current_page'] = Variable<int>(currentPage.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $BooksTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (lastAccess.present) {
      map['last_access'] = Variable<DateTime>(lastAccess.value);
    }
    if (bookCfi.present) {
      map['book_cfi'] = Variable<String>(bookCfi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksTableCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('title: $title, ')
          ..write('coverPath: $coverPath, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPage: $currentPage, ')
          ..write('status: $status, ')
          ..write('lastAccess: $lastAccess, ')
          ..write('bookCfi: $bookCfi')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTableTable booksTable = $BooksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [booksTable];
}

typedef $$BooksTableTableCreateCompanionBuilder =
    BooksTableCompanion Function({
      Value<int> id,
      required String path,
      required String title,
      required String coverPath,
      required int totalPages,
      Value<int> currentPage,
      Value<BookStatus> status,
      Value<DateTime?> lastAccess,
      Value<String?> bookCfi,
    });
typedef $$BooksTableTableUpdateCompanionBuilder =
    BooksTableCompanion Function({
      Value<int> id,
      Value<String> path,
      Value<String> title,
      Value<String> coverPath,
      Value<int> totalPages,
      Value<int> currentPage,
      Value<BookStatus> status,
      Value<DateTime?> lastAccess,
      Value<String?> bookCfi,
    });

class $$BooksTableTableFilterComposer
    extends Composer<_$AppDatabase, $BooksTableTable> {
  $$BooksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BookStatus, BookStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get lastAccess => $composableBuilder(
    column: $table.lastAccess,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookCfi => $composableBuilder(
    column: $table.bookCfi,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BooksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTableTable> {
  $$BooksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAccess => $composableBuilder(
    column: $table.lastAccess,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookCfi => $composableBuilder(
    column: $table.bookCfi,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTableTable> {
  $$BooksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPage => $composableBuilder(
    column: $table.currentPage,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BookStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccess => $composableBuilder(
    column: $table.lastAccess,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookCfi =>
      $composableBuilder(column: $table.bookCfi, builder: (column) => column);
}

class $$BooksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTableTable,
          BooksTableData,
          $$BooksTableTableFilterComposer,
          $$BooksTableTableOrderingComposer,
          $$BooksTableTableAnnotationComposer,
          $$BooksTableTableCreateCompanionBuilder,
          $$BooksTableTableUpdateCompanionBuilder,
          (
            BooksTableData,
            BaseReferences<_$AppDatabase, $BooksTableTable, BooksTableData>,
          ),
          BooksTableData,
          PrefetchHooks Function()
        > {
  $$BooksTableTableTableManager(_$AppDatabase db, $BooksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> coverPath = const Value.absent(),
                Value<int> totalPages = const Value.absent(),
                Value<int> currentPage = const Value.absent(),
                Value<BookStatus> status = const Value.absent(),
                Value<DateTime?> lastAccess = const Value.absent(),
                Value<String?> bookCfi = const Value.absent(),
              }) => BooksTableCompanion(
                id: id,
                path: path,
                title: title,
                coverPath: coverPath,
                totalPages: totalPages,
                currentPage: currentPage,
                status: status,
                lastAccess: lastAccess,
                bookCfi: bookCfi,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String path,
                required String title,
                required String coverPath,
                required int totalPages,
                Value<int> currentPage = const Value.absent(),
                Value<BookStatus> status = const Value.absent(),
                Value<DateTime?> lastAccess = const Value.absent(),
                Value<String?> bookCfi = const Value.absent(),
              }) => BooksTableCompanion.insert(
                id: id,
                path: path,
                title: title,
                coverPath: coverPath,
                totalPages: totalPages,
                currentPage: currentPage,
                status: status,
                lastAccess: lastAccess,
                bookCfi: bookCfi,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTableTable,
      BooksTableData,
      $$BooksTableTableFilterComposer,
      $$BooksTableTableOrderingComposer,
      $$BooksTableTableAnnotationComposer,
      $$BooksTableTableCreateCompanionBuilder,
      $$BooksTableTableUpdateCompanionBuilder,
      (
        BooksTableData,
        BaseReferences<_$AppDatabase, $BooksTableTable, BooksTableData>,
      ),
      BooksTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableTableManager get booksTable =>
      $$BooksTableTableTableManager(_db, _db.booksTable);
}
