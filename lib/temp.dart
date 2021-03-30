// readyToStart() async {
//   FirebaseProvider firebaseProvider =
//   Provider.of<FirebaseProvider>(context, listen: false);
//   CustomUserProvider customUserProvider =
//   Provider.of<CustomUserProvider>(context, listen: false);
//   User user = FirebaseAuth.instance.currentUser;
//
//   customUserProvider.customUser = CustomUser.fromSnapshot(
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(user.email)
//           .get());
//
//   if (customUserProvider.customUser == null) {
//     customUserProvider.customUser = CustomUser(
//       name: user.displayName == null ? "null" : user.displayName,
//       email: user.email,
//       contact: user.phoneNumber == null ? "null" : user.phoneNumber,
//       address: "null",
//       favorites: <String>[],
//     );
//     customUserProvider.setCustomUser();
//   }
//
//   await customUserProvider.getCustomUser();
//   await firebaseProvider.getItems();
//   await Provider.of<CartProvider>(context, listen: false)
//       .getFavoriteItems(customUserProvider, firebaseProvider);
// }