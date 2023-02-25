import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/app_interceptor.dart';
import 'package:posts_app/core/api/dio_consumer.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/remote_datasource.dart';
import 'package:posts_app/features/posts/data/repositories/add_post_repo_impl.dart';
import 'package:posts_app/features/posts/data/repositories/post_repo_impl.dart';
import 'package:posts_app/features/posts/domain/repositories/add_post_repository.dart';
import 'package:posts_app/features/posts/domain/repositories/delete_post_repository.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/repositories/update_post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/data/datasources/local_datasource.dart';
import 'features/posts/data/repositories/delete_post_repo_impl.dart';
import 'features/posts/data/repositories/update_post_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Featuers

  // Blocs
  sl.registerFactory<PostsCubit>(
    () => PostsCubit(
      getAllPostsUseCase: sl(),
      addNewPostUseCase: sl(),
      deletePostUseCase: sl(),
      updatePostUseCase: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetAllPostsUseCase>(
      () => GetAllPostsUseCase(postsRepository: sl()));

  sl.registerLazySingleton<AddNewPostUseCase>(
      () => AddNewPostUseCase(addNewPostRepository: sl()));

  sl.registerLazySingleton<DeletePostUseCase>(
      () => DeletePostUseCase(deletePostRepository: sl()));

  sl.registerLazySingleton<UpdatePostUseCase>(
      () => UpdatePostUseCase(updatePostRepository: sl()));

  // Repositories
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      postsRemoteDatasource: sl(),
      postsLocalDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AddNewPostRepository>(
    () => AddNewPostRepositoryImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );

  sl.registerLazySingleton<DeletePostRepository>(
    () => DeletePostRepositoryImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );

  sl.registerLazySingleton<UpdatePostRepository>(
    () => UpdatePostRepositoryImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<PostsRemoteDatasource>(
    () => PostsRemoteDatasourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<PostsLocalDatasource>(
    () => PostsLocalDatasourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: sl()),
  );
  //! Externals
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
