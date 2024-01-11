import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/service/task_service.dart';

class MockBackendClient extends Mock implements BackendClient {}

void main() {
  Task task = const Task(name: 'example task', status: TaskStatus.todo);
  Task completeTask = const Task(name: 'example task', status: TaskStatus.completed);
  Task recycledTask = const Task(name: 'example task', status: TaskStatus.recycled);
  Task deletedTask = const Task(name: 'example task,', status: TaskStatus.deleted);
  late TaskService sut;
  late MockBackendClient testClient;
  setUp(() {
    testClient = MockBackendClient();
    sut = TaskService(client: testClient);
  });

  test('Reads Tasks', () async {
    when(() => testClient.getData(uri: any(named: 'uri'), queryParams: {'status': 'todo'})).thenAnswer((invocation) => Future.value([
          {'name': 'example task', 'status': 'todo'}
        ]));
    List<Task> actual = await sut.readTasksByStatus(TaskStatus.todo);
    List<Task> expected = [const Task(name: 'example task', status: TaskStatus.todo)];
    expect(actual, expected);
  });

  test('Read Tasks Throws Exception', () async {
    when(() => testClient.getData(uri: any(named: 'uri'), queryParams: any(named: 'queryParams'))).thenThrow(Exception);
    expect(() => sut.readTasksByStatus(TaskStatus.completed), throwsA(const TypeMatcher<Exception>()));
  });

  test('Reads Tasks Negative', () async {
    when(() => testClient.getData(uri: any(named: 'uri'), queryParams: {'status': 'todo'})).thenAnswer((invocation) => Future.value([]));
    List<Task> actual = await sut.readTasksByStatus(TaskStatus.todo);
    List<Task> expected = [const Task(name: 'example task', status: TaskStatus.todo)];
    expect(actual, isNot(equals(expected)));
  });

  test('Adds Task', () async {
    when(() => testClient.postData(uri: any(named: 'uri'), body: any(named: 'body'))).thenAnswer((invocation) => Future.value('this is a test'));

    expect(() => sut.addTask(task: const Task(name: 'example task', status: TaskStatus.todo)), returnsNormally);
  });

  test('Add Task gets Error Message', () {
    when(() => testClient.postData(uri: any(named: 'uri'), body: any(named: 'body'))).thenThrow(Exception);
    expect(() => sut.addTask(task: const Task(name: 'example task', status: TaskStatus.todo)), throwsA(const TypeMatcher<Exception>()));
  });

  test('Edit Task Succeeds', () async {
    when(() => testClient.putData(uri: any(named: 'uri'), body: any(named: 'body'))).thenAnswer((invocation) => Future.value('this is a test'));

    expect(() => sut.updateTask(task: const Task(name: 'example task', status: TaskStatus.todo)), returnsNormally);
  });

  test('Delete Task Succeeds', () async {
    when(() => testClient.deleteData(
          uri: any(named: 'uri'),
        )).thenAnswer((invocation) => Future.value());

    expect(() => sut.deleteTask(task: deletedTask), returnsNormally);
  });

  test('Delete Task Fails', () async {
    when(() => testClient.deleteData(
          uri: any(named: 'uri'),
        )).thenThrow(Exception);

    expect(() => sut.deleteTask(task: deletedTask), throwsA(const TypeMatcher<Exception>()));
  });

  test('Complete Task Succeeds', () async {
    when(() => testClient.putData(uri: any(named: 'uri'), body: any(named: 'body'))).thenAnswer((invocation) => Future<void>.value(null));

    expect(() => sut.updateTask(task: completeTask), returnsNormally);
  });

  test('Recycle Task Succeeds', () async {
    when(() => testClient.putData(uri: any(named: 'uri'), body: any(named: 'body'))).thenAnswer((invocation) => Future.value(null));

    expect(() => sut.updateTask(task: recycledTask), returnsNormally);
  });

  test('Recover Task Succeeds', () async {
    when(() => testClient.putData(uri: any(named: 'uri'), body: any(named: 'body'))).thenAnswer((invocation) => Future.value(null));

    expect(() => sut.updateTask(task: task), returnsNormally);
  });

  test('Recover Task Fails', () async {
    when(() => testClient.putData(uri: any(named: 'uri'), body: any(named: 'body'))).thenThrow(Exception);

    expect(() => sut.updateTask(task: task), throwsA(const TypeMatcher<Exception>()));
  });
}
