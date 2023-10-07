# Task Management Application

The Task Management Application is a mobile app designed to help users manage their tasks efficiently. It provides features for creating, categorizing, and organizing tasks into three categories: to-do, doing, and done. Additionally, the app includes a passcode lock screen for added security and user convenience.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/) installed on your development environment.

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/task-management-app.git
   ```

2. Navigate to the project folder:

   ```bash
   cd task-management-app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Usage

1. The main screen consists of three tabs: "To-Do," "Doing," and "Done." Each tab displays a list of tasks based on their status.

2. Tasks are grouped by date and ordered by their creation date in ascending order.

3. As you scroll through the task list, the app will load additional tasks automatically when you approach the last item.

4. To delete a task, swipe left or right on the task item. This action removes the task locally.

5. The passcode lock screen will activate under the following conditions:

   - After 10 seconds of user inactivity.
   - When the user kills and reopens the application.
   - When the user closes and reopens the application after 10 seconds.

6. To unlock the app, enter the default passcode "123456." Note that setting or editing the passcode is not available in this version.

## Testing

### Unit Tests

To run unit tests, use the following:

    ```bash
    flutter test
    ```

### Integration Tests

Use the following to run integration tests:

    ```bash
    flutter test integration_test
    ```
