import 'package:bloc_test/bloc_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/service/task_service.dart';

// Cubits
class MockTaskCubit extends MockCubit<TaskState> implements TaskCubit{}

// Services
class MockTaskService extends Mock implements TaskService{}

// Other
class MockGoRouter extends Mock implements GoRouter {}