import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/application/bloc/apply_bloc.dart';
import 'package:jobportal/application/bloc/apply_event.dart';
import 'package:jobportal/application/bloc/apply_state.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';

import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockJobDataSource extends Mock implements JobDataSource {}

void main() {
  late ApplyBloc applyBloc;
  late JobDataSource jobDataSource;

  setUp(() {
    jobDataSource = MockJobDataSource();
    applyBloc = ApplyBloc()..add(ApplicationRequested(id: '1'));
  });

  group('ApplyBloc', () {
    test('emits correct states when application is successful', () async {
      final jobId = '1';
      when(() => jobDataSource.ApplyToJob(jobId))
          .thenAnswer((_) async => right(true));

      expect(
        applyBloc,
        emitsInOrder([
          ApplyState(status: AppliedStatus.requestInProgress),
          ApplyState(status: AppliedStatus.applied, appliedJobs: [jobId]),
        ]),
      );
    });

    test('emits correct states when application already applied', () async {
      final jobId = '1';
      when(() => jobDataSource.checkApplied(jobId))
          .thenAnswer((_) async => true);

      expect(
        applyBloc,
        emitsInOrder([
          ApplyState(status: AppliedStatus.requestInProgress),
          ApplyState(status: AppliedStatus.applied, appliedJobs: [jobId]),
        ]),
      );
    });

    test('emits correct states when application not applied', () async {
      final jobId = '1';
      when(() => jobDataSource.checkApplied(jobId))
          .thenAnswer((_) async => false);

      expect(
        applyBloc,
        emitsInOrder([
          ApplyState(status: AppliedStatus.requestInProgress),
          ApplyState(status: AppliedStatus.notApplied, checked: [jobId]),
        ]),
      );
    });
  });
}
