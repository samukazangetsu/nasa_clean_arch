import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/space_media/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/space_media/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/space_media/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  GetSpaceMediaFromDateUseCase useCase;
  ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    useCase = GetSpaceMediaFromDateUseCase(repository: repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );

  final tDate = DateTime(2021, 26, 07);

  test(
    'should get [SpaceMediaEntity] media for a given date from the repository',
    () async {
      // arrange
      when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia),
      );

      // act
      final result = await useCase(tDate);

      // assert
      expect(result, Right(tSpaceMedia));
      verify(() => repository.getSpaceMediaFromDate(tDate));
    },
  );

  test(
    'should return a [ServerException] when do not succeed',
    () async {
      // arramge
      when(() => repository.getSpaceMediaFromDate(tDate))
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await useCase(tDate);

      // expect
      expect(result, Left(ServerFailure()));
      verify(() => repository.getSpaceMediaFromDate(tDate));
    },
  );
}
