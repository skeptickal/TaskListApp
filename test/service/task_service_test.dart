import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/service/task_service.dart';

class MockBackendClient extends Mock implements BackendClient {}

void main() {
  late TaskService sut;
  late MockBackendClient testClient;
  setUp(() {
    testClient = MockBackendClient();
    sut = TaskService(client: testClient);
  });

  test('Reads Tasks', () async {
    when(() => testClient.getData(uri: any(named: 'uri')))
        .thenAnswer((invocation) => Future.value([
              {'name': 'example task'}
            ]));
    List<Task> actual = await sut.readTasks();
    List<Task> expected = [const Task(name: "example task")];
    expect(actual, expected);
  });

  test('Reads Tasks Negative', () async {
    when(() => testClient.getData(uri: any(named: 'uri')))
        .thenAnswer((invocation) => Future.value([
              {'name': 'failed example task'}
            ]));
    List<Task> actual = await sut.readTasks();
    List<Task> expected = [const Task(name: "example task")];
    expect(actual, isNot(equals(expected)));
  });

  test('Adds Task', () async {
    when(() => testClient.postData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(() => sut.addTask(taskName: const Task(name: "example task")),
        returnsNormally);
  });

  test('Add Task gets Error Message', () {
    when(() => testClient.postData(
        uri: any(named: 'uri'), body: any(named: 'body'))).thenThrow(Exception);
    expect(() => sut.addTask(taskName: const Task(name: "example task")),
        throwsA(const TypeMatcher<Exception>()));
  });
}
