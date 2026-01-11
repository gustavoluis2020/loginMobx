import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'features/login/data/datasources/login_remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/stores/login_store.dart';
import 'features/text_notes/data/datasources/text_note_local_data_source.dart';
import 'features/text_notes/data/datasources/text_note_local_data_source_impl.dart';
import 'features/text_notes/data/models/text_note_model.dart';
import 'features/text_notes/data/repositories/text_note_repository_impl.dart';
import 'features/text_notes/domain/repositories/text_note_repository.dart';
import 'features/text_notes/domain/usecases/delete_text_note_usecase.dart';
import 'features/text_notes/domain/usecases/get_text_notes_usecase.dart';
import 'features/text_notes/domain/usecases/save_text_note_usecase.dart';
import 'features/text_notes/presentation/stores/text_notes_store.dart';
import 'features/statistics/presentation/stores/statistics_store.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Login
  // Store
  sl.registerFactory(() => LoginStore(sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());

  // Features - Text Notes
  // Store
  sl.registerFactory(() => TextNotesStore(sl(), sl(), sl()));

  // Features - Statistics
  // Store
  sl.registerFactory(() => StatisticsStore(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTextNotesUseCase(sl()));
  sl.registerLazySingleton(() => SaveTextNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTextNoteUseCase(sl()));

  // Repository
  sl.registerLazySingleton<TextNoteRepository>(() => TextNoteRepositoryImpl(localDataSource: sl()));

  // Data sources
  final box = await Hive.openBox<TextNoteModel>('text_notes');
  sl.registerLazySingleton<TextNoteLocalDataSource>(() => TextNoteLocalDataSourceImpl(box: box));
}
