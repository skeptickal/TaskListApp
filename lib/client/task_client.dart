class TaskClient {
  const TaskClient();

//functions to connect with API
  List<String> getTasks() {
    //get tasks from API @GetRequest
    return ["tasks"];
  }

  void addTask(String taskName) {
    //add task to API @PostRequest
  }

  void completeTask(String taskName) {
    //remove from current tasks, add to completed tasks list @PutRequest, refactor cubit later
  }

  //deleteTasks - remove completely from API and view
  //complete rask
}
