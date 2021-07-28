import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/features/space_media/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_media/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/features/space_media/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImpl implements ISpaceMediaRepository {
  final ISpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await dataSource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
