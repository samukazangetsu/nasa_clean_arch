import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/space_media/data/datasources/space_media_data_source.dart';
import 'package:nasa_clean_arch/features/space_media/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/space_media/data/repositories/space_media_repository_impl.dart';

class MockSpaceMediaDataSourceImpl extends Mock
    implements ISpaceMediaDataSource {}

void main() {
  SpaceMediaRepositoryImpl repositoryImpl;
  ISpaceMediaDataSource dataSource;

  setUp(
    () {
      dataSource = MockSpaceMediaDataSourceImpl();
      repositoryImpl = SpaceMediaRepositoryImpl(dataSource);
    },
  );

  final tDate = DateTime(2021, 26, 07);

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaUrl: 'mediaUrl',
    mediaType: 'mediaType',
    title: 'title',
  );

  test(
    'shoul return [SpaceMediaModel] when the data source is successfully called',
    () async {
      // arrange
      when(() => dataSource.getSpaceMediaFromDate(tDate))
          .thenAnswer((_) async => tSpaceMediaModel);

      // act
      final result = await repositoryImpl.getSpaceMediaFromDate(tDate);

      // assert
      verify(() => dataSource.getSpaceMediaFromDate(tDate));
      expect(result, Right(tSpaceMediaModel));
    },
  );

  test(
    'shoudl return a [ServerFailure] when the data source is unseccefull called',
    () async {
      //arange
      when(() => dataSource.getSpaceMediaFromDate(tDate))
          .thenThrow(ServerException());

      //assert
      final result = await repositoryImpl.getSpaceMediaFromDate(tDate);

      //act
      expect(result, Left(ServerFailure()));
      verify(() => dataSource.getSpaceMediaFromDate(tDate));
    },
  );
}
