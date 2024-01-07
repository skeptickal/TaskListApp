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
    when(() => testClient
            .getData(uri: any(named: 'uri'), queryParams: {'status': 'todo'}))
        .thenAnswer((invocation) => Future.value([
              {'name': 'example task', 'status': 'todo'}
            ]));
    List<Task> actual = await sut.readTasksByStatus(TaskStatus.todo);
    List<Task> expected = [
      const Task(name: 'example task', status: TaskStatus.todo)
    ];
    expect(actual, expected);
  });

  test('Reads Tasks Negative', () async {
    when(() => testClient
            .getData(uri: any(named: 'uri'), queryParams: {'status': 'todo'}))
        .thenAnswer((invocation) => Future.value([]));
    List<Task> actual = await sut.readTasksByStatus(TaskStatus.todo);
    List<Task> expected = [
      const Task(name: 'example task', status: TaskStatus.todo)
    ];
    expect(actual, isNot(equals(expected)));
  });

  test('Adds Task', () async {
    when(() => testClient.postData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(
        () => sut.addTask(
            task: const Task(name: 'example task', status: TaskStatus.todo)),
        returnsNormally);
  });

  test('Add Task gets Error Message', () {
    when(() => testClient.postData(
        uri: any(named: 'uri'), body: any(named: 'body'))).thenThrow(Exception);
    expect(
        () => sut.addTask(
            task: const Task(name: 'example task', status: TaskStatus.todo)),
        throwsA(const TypeMatcher<Exception>()));
  });

  test('Edit Task Succeeds', () async {
    when(() => testClient.putData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(
        () => sut.updateTask(
            task: const Task(name: 'example task', status: TaskStatus.todo)),
        returnsNormally);
  });

  test('Complete Task Succeeds', () async {
    when(() => testClient.putData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(
        () => sut.updateTask(
            task:
                const Task(name: 'example task', status: TaskStatus.completed)),
        returnsNormally);
  });

  test('Delete Task Succeeds', () async {
    when(() => testClient.deleteData(
          uri: any(named: 'uri'),
        )).thenAnswer((invocation) => Future.value());

    expect(
        () => sut.deleteTask(
            task: const Task(name: 'example task', status: TaskStatus.deleted)),
        returnsNormally);
  });

  test('Recycle Task Succeeds', () async {
    when(() => testClient.putData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(
        () => sut.updateTask(
            task:
                const Task(name: 'example task', status: TaskStatus.recycled)),
        returnsNormally);
  });

  test('Recover Task Succeeds', () async {
    when(() => testClient.putData(
            uri: any(named: 'uri'), body: any(named: 'body')))
        .thenAnswer((invocation) => Future.value('this is a test'));

    expect(
        () => sut.updateTask(
            task: const Task(name: 'example task', status: TaskStatus.todo)),
        returnsNormally);
  });

  test('Recover Task Fails', () async {
    when(() => testClient.putData(
        uri: any(named: 'uri'), body: any(named: 'body'))).thenThrow(Exception);

    expect(
        () => sut.updateTask(
            task: const Task(name: 'example task', status: TaskStatus.todo)),
        throwsA(const TypeMatcher<Exception>()));
  });
}
