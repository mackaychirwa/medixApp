import '../models/userdata.dart';

class G {
  static List<UserData>? dummyUsers;

  static UserData? loggedInUser;

  static void initDummyUsers() {
    // UserData userA = UserData(id: "1", email: "admin@chitawira.com", password: "1234");
    // UserData userB = UserData(id: "2", email: "admin@medix.com", password: "1234");
    // dummyUsers = [];
    // dummyUsers!.add(userA);
    // dummyUsers!.add(userB);
  }
  static List<UserData> getUsersFor(UserData user) {
    List<UserData> filteredusers = dummyUsers!.where((u) => (!u.email.toLowerCase()
        .contains(user.email.toLowerCase()
    )
    )
    ).toList();
    return filteredusers;
  }
}