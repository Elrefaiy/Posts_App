import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/api/api_consumer.dart';
import 'package:posts_app/core/api/app_interceptor.dart';
import 'package:posts_app/core/api/dio_consumer.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/remote_datasource.dart';
import 'package:posts_app/features/posts/data/repositories/post_repo_impl.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:posts_app/features/posts/presentation/cubit/posts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Featuers

  // Blocs
  sl.registerFactory<PostsCubit>(() => PostsCubit(getAllPostsUseCase: sl()));

  // Use Cases

  sl.registerLazySingleton<GetAllPostsUseCase>(
      () => GetAllPostsUseCase(postsRepository: sl()));

  // Repositories
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      postsRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<PostsRemoteDatasource>(
    () => PostsRemoteDatasourceImpl(apiConsumer: sl()),
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
}
