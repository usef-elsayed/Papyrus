// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/activity/data/repository/ActivityRepositoryImpl.dart'
    as _i93;
import '../../features/activity/domain/repository/ActivityRepository.dart'
    as _i1069;
import '../../features/activity/domain/usecase/GetLastAccessedBooksUseCase.dart'
    as _i317;
import '../../features/activity/presentation/cubit/ActivityCubit.dart' as _i234;
import '../../features/library/data/repository/LibraryRepositoryImpl.dart'
    as _i301;
import '../../features/library/domain/repository/LibraryRepository.dart'
    as _i777;
import '../../features/library/domain/usecase/AddBookUseCase.dart' as _i871;
import '../../features/library/domain/usecase/DeleteBooksUseCase.dart' as _i492;
import '../../features/library/domain/usecase/GetBooksUseCase.dart' as _i639;
import '../../features/library/presentation/bloc/LibraryBloc.dart' as _i734;
import '../../features/reader/data/repository/ReaderRepositoryImpl.dart'
    as _i887;
import '../../features/reader/domain/repository/ReaderRepository.dart' as _i963;
import '../../features/reader/domain/usecase/LoadBookFileUseCase.dart' as _i575;
import '../../features/reader/domain/usecase/UpdateBookProgressUseCase.dart'
    as _i216;
import '../../features/reader/presentation/bloc/ReaderBloc.dart' as _i360;
import '../database/database/AppDatabase.dart' as _i1016;
import '../services/FileService.dart' as _i1059;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1016.AppDatabase>(() => _i1016.AppDatabase());
    gh.lazySingleton<_i1059.FileHelper>(() => _i1059.FileHelper());
    gh.lazySingleton<_i575.LoadBookFileUseCase>(
      () => _i575.LoadBookFileUseCase(),
    );
    gh.lazySingleton<_i963.ReaderRepository>(
      () => _i887.ReaderRepositoryImpl(gh<_i1016.AppDatabase>()),
    );
    gh.lazySingleton<_i777.LibraryRepository>(
      () => _i301.LibraryRepositoryImpl(gh<_i1016.AppDatabase>()),
    );
    gh.lazySingleton<_i1069.ActivityRepository>(
      () => _i93.ActivityRepositoryImpl(gh<_i1016.AppDatabase>()),
    );
    gh.lazySingleton<_i216.UpdateBookProgressUseCase>(
      () => _i216.UpdateBookProgressUseCase(gh<_i963.ReaderRepository>()),
    );
    gh.factory<_i360.ReaderBloc>(
      () => _i360.ReaderBloc(
        gh<_i575.LoadBookFileUseCase>(),
        gh<_i216.UpdateBookProgressUseCase>(),
      ),
    );
    gh.lazySingleton<_i871.AddBookUseCase>(
      () => _i871.AddBookUseCase(gh<_i777.LibraryRepository>()),
    );
    gh.lazySingleton<_i492.DeleteBooksUseCase>(
      () => _i492.DeleteBooksUseCase(gh<_i777.LibraryRepository>()),
    );
    gh.lazySingleton<_i639.GetBooksUseCase>(
      () => _i639.GetBooksUseCase(gh<_i777.LibraryRepository>()),
    );
    gh.lazySingleton<_i317.GetLastAccessedBooksUseCase>(
      () => _i317.GetLastAccessedBooksUseCase(gh<_i1069.ActivityRepository>()),
    );
    gh.factory<_i734.LibraryBloc>(
      () => _i734.LibraryBloc(
        gh<_i639.GetBooksUseCase>(),
        gh<_i871.AddBookUseCase>(),
        gh<_i492.DeleteBooksUseCase>(),
      ),
    );
    gh.factory<_i234.ActivityCubit>(
      () => _i234.ActivityCubit(gh<_i317.GetLastAccessedBooksUseCase>()),
    );
    return this;
  }
}
