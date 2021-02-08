import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants/firestore_keys.dart';
import 'package:instagram_clone/models/firestore/user_model.dart';
import 'package:instagram_clone/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attempCreateUser({String userKey, String email}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(UserModel.getMapforCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    //.get()은 하나의 퓨처값, snapshots는 여러개의 스트림값
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }
// //data 넣기
  // Future<void> sendData() {
  //   return FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc('123123123')
  //       .set({'email': 'testing@gmail.com', 'username': 'myusername'});
  // }
  //
  // //data 가져오기
  // void getData() {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc('123123123')
  //       .get()
  //       .then((docSnapshot) => print(docSnapshot.data()));
  // }
}

//다른 파일에서 쓸 수 있도록 내보기
UserNetworkRepository userNetworkRepository = UserNetworkRepository();
