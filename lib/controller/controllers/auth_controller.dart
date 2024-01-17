import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/user_model.dart';
import '../../services/firestore_methods.dart';
import '../../utilites/my_strings.dart';
import '../../utilites/themes.dart';

class AuthController extends GetxController {
  final GetStorage authBox = GetStorage();

  bool isVisibilty = false;
  bool isChecked = false;
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
  var userRole = "".obs;
  final myData = Rxn<UserModel>();

  @override
  void onInit() async {

    // TODO: implement onInit
    authBox.read(KUid) !=null?  getMyData():null;
    super.onInit();
  }

  ///get my data from firebase
  getMyData() async {
    String myId = await authBox.read(KUid);
    String myRole = await authBox.read('role');
    if (myRole.isNotEmpty && myId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(myRole)
          .doc(myId)
          .get()
          .then((value) {
        myData.value = UserModel.fromMap(value.data());

        update();
      });
    }

    update();
  }

  void visibility() {
    isVisibilty = !isVisibilty;
    update();
  }

  void checked() {
    isChecked = !isChecked;
    update();
  }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await authBox.write(KUid, value.user!.uid);
        uid = value.user!.uid;
        update();

        auth.currentUser!.updateDisplayName(name);
        // PatientFireStoreMethods().insertInfoFireStorage(
        //     name,
        //     email,
        //     value.user!.uid,
        //     "profileUrl",
        //     phoneNumber,
        //     patientGender.value,
        //     patientsCollectionKey,
        //     false);

        update();
        await FireStoreMethods()
            .insertStudentsInfoFireStorage(name, email, uid, role)
            .then((v) {
          isLoading.value = false;
          update();
          authBox.write("role", role);

          role == studentRole
              ? Get.offNamed(Routes.homeScreen)
              : Get.offNamed(Routes.adminHomeScreen);
          update();
        });
      });
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      update();

      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'weak-password') {
        message = "password is too weak.";
        title = error.code.toString();

        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        message = "account already exists ";

        print('The account already exists for that email.');
      } else {
        message = error.message.toString();
      }

      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: MAINCOLOR,
          cancelTextColor: PARAGRAPH,
          backgroundColor: WHITE);
      // Get.snackbar(
      //   title,
      //   message,
      //   snackPosition: SnackPosition.TOP,
      // );
    } catch (error) {
      Get.snackbar(
        "Error",
        "$error",
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  void loginUsingFirebase({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      isLoading.value = true;
      update();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        authBox.write(KUid, value.user!.uid.toString());
        String uid = value.user!.uid;

        var querySnapshot =
            await FirebaseFirestore.instance.collection(role).doc(uid).get();
        if (querySnapshot.exists) {
          // The UID exists in the collection foadmin@m.comr the specified role
          // Do something here (e.g., navigate to the next screen)
          authBox.write("role", role);
          isLoading.value = false;
          role == studentsCollectionKey
              ? Get.offNamed(Routes.homeScreen)
              : Get.offNamed(Routes.adminHomeScreen);
        } else {
          Get.defaultDialog(
              title: "error",
              middleText: "please insert correct data",
              textCancel: "Ok",
              buttonColor: MAINCOLOR,
              cancelTextColor: PARAGRAPH,
              backgroundColor: WHITE);
          isLoading.value = false;
          // The UID does not exist in the collection for the specified role
          // Handle accordingly
        }

        update();
      });
      update();

//      displayUserId.value = await GetStorage().read("uid");

      update();
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      update();
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'user-not-found') {
        message =
            "Account does not exists for that $email.. Create your account by signing up..";
      } else if (error.code == 'wrong-password') {
        message = "Invalid Password... PLease try again!";
      } else {
        message = error.message.toString();
      }
      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: MAINCOLOR,
          cancelTextColor: PARAGRAPH,
          backgroundColor: WHITE);
    } catch (error) {
      isLoading.value = false;
      Get.defaultDialog(
          title: "error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: MAINCOLOR,
          cancelTextColor: PARAGRAPH,
          backgroundColor: WHITE);
      print(error);
    }
  }

  ////////////////////////////////signOut//////////////////////////////////////
  void signOutFromApp() async {
    try {
      await auth.signOut();
      // displayUserName.value = "";
      // displayUserPhoto.value = "";
      // displayUserEmail.value = "";
      authBox.remove("role");
      authBox.erase();

      update();
      Get.offAllNamed(Routes.loginScreen);
    } catch (error) {
      Get.defaultDialog(
          title: "error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: MAINCOLOR,
          cancelTextColor: PARAGRAPH,
          backgroundColor: WHITE);
    }
  }
}
