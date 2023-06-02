// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplication_salesiana/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class AuthMethods {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final firestore.CollectionReference usuariosCollection =
      firestore.FirebaseFirestore.instance.collection("usuarios");
  //get email
  Future<String> getUserEmail() async {
    User currentUser = _auth.currentUser!;
    return currentUser.email!;
  }

  // get user details
  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(documentSnapshot);
  // }

  // Signing Up User

  // Future<String> signUpUser({
  //   required String email,
  //   required String password,
  //   required String username,
  //   required String bio,
  //   required Uint8List file,
  // }) async {
  //   String res = "Some error Occurred";
  //   try {
  //     if (email.isNotEmpty ||
  //         password.isNotEmpty ||
  //         username.isNotEmpty ||
  //         bio.isNotEmpty ||
  //         file != null) {
  //       // registering user in auth with email and password
  //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       String photoUrl =
  //           await StorageMethods().uploadImageToStorage('profilePics', file, false);

  //       model.User _user = model.User(
  //         username: username,
  //         uid: cred.user!.uid,
  //         photoUrl: photoUrl,
  //         email: email,
  //         bio: bio,
  //         followers: [],
  //         following: [],
  //       );

  //       // adding user in our database
  //       await _firestore
  //           .collection("users")
  //           .doc(cred.user!.uid)
  //           .set(_user.toJson());

  //       res = "success";
  //     } else {
  //       res = "Please enter all the fields";
  //     }
  //   } catch (err) {
  //     return err.toString();
  //   }
  //   return res;
  // }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Ocurrió algún error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        print(email + password);
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "éxito";
      } else {
        res = "Ingrese todos los campos";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<Usuario?> getUserDetails(String correo) async {
    Usuario? usuario;
    try {
      final firestore.QuerySnapshot snapshot =
          await usuariosCollection.where('correo', isEqualTo: correo).get();
      usuario = snapshot.docs
          .map((doc) => Usuario.fromJson(doc.data() as Map<String, dynamic>))
          .toList()[0];
      return usuario;
    } catch (e) {
      print(e);
      return usuario;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
