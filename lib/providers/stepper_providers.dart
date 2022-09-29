import 'package:flutter/foundation.dart';
import 'package:stepper_flutter/models/stepper_models.dart';

class StepperProvider with ChangeNotifier {
  List<StepperModels> users = [
    StepperModels(
        username: 'User1', password: 'User1@0000', email: 'user1@gmail.com'),
    StepperModels(
        username: 'User2', password: 'User2@0000', email: 'user2@gmail.com'),
    StepperModels(
        username: 'User3', password: 'User3@0000', email: 'user3@gmail.com'),
    StepperModels(
        username: 'User4', password: 'User4@0000', email: 'user4@gmail.com'),
    StepperModels(
        username: 'User5', password: 'User5@0000', email: 'user5@gmail.com'),
    StepperModels(
        username: 'User6', password: 'User6@0000', email: 'user6@gmail.com'),
  ];

  List<StepperModels> getUsers() => users;

  void add(StepperModels data) {
    users.insert(0, data);
    notifyListeners();
  }

  void remove(int index) {
    users.removeAt(index);
    notifyListeners();
  }
}
