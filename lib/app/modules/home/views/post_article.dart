// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heyva_web_admin/app/modules/home/controllers/menu_controller.dart';
// import 'package:heyva_web_admin/constant/colors.dart';
// import 'package:file_picker/file_picker.dart';
//
// import 'admin_common.dart';
//
//
// class CreateArticlePage extends StatefulWidget {
//   const CreateArticlePage({Key? key}) : super(key: key);
//
//   @override
//   _CreateArticlePage createState() => _CreateArticlePage();
// }
//
//
// class _CreateArticlePage extends State<CreateArticlePage> {
//   final TextEditingController titleEditingController = TextEditingController();
//   final TextEditingController dateEditingController = TextEditingController();
//   final TextEditingController categoryEditingController = TextEditingController();
//   final TextEditingController htmlEditingController = TextEditingController();
//   Uint8List imageValue = Uint8List(0);
//   Uint8List htmlValue = Uint8List(0);
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     String pageName = sideMenuItems[SideMenuItems.newArticle.index];
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   pageName,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(width: 120,),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
//                     textStyle: MaterialStateProperty.all(
//                       const TextStyle(fontSize: 16),
//                     ),
//                     backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                   child: const Text('Compose'),
//                 ),
//                 const SizedBox(width: 20,),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
//                     textStyle: MaterialStateProperty.all(
//                       const TextStyle(fontSize: 16),
//                     ),
//                     backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       // Icon(Icons.check),
//                       // SizedBox(width: 10),
//                       Text('Submit')
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TitleField(),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 const SizedBox(
//                   width: 200,
//                   child: Text(
//                     'Title',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: TextField(
//                       onChanged: (text) {
//                         // debugPrint("Article title: ${titleEditingController.text}");
//                       },
//                       controller: titleEditingController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         hintText: 'Article title',
//                         fillColor: CupertinoColors.secondarySystemFill,
//                         filled: true,
//                         hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
//                       ),
//                       cursorColor: ColorApp.grey_font,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 const SizedBox(
//                   width: 200,
//                   child: Text(
//                     'Category',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: TextField(
//                       onChanged: (text) {
//                         // debugPrint("Article category: ${categoryEditingController.text}");
//                       },
//                       controller: categoryEditingController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         hintText: 'Article category',
//                         fillColor: CupertinoColors.secondarySystemFill,
//                         filled: true,
//                         hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
//                       ),
//                       cursorColor: ColorApp.grey_font,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 const SizedBox(
//                   width: 200,
//                   child: Text(
//                     'Date',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: SelectDate(controller: dateEditingController,),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
//               child: Row(
//                 children: <Widget>[
//                   const SizedBox(
//                     width: 200,
//                     child: Text(
//                       'Photo',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () => uploadImage(),
//                     style: ButtonStyle(
//                       padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
//                       textStyle: MaterialStateProperty.all(
//                         const TextStyle(fontSize: 16),
//                       ),
//                       backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.file_upload),
//                         SizedBox(width: 10),
//                         Text('Upload Picture')
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: imageValue.isEmpty ? const Text("No image !") : const Text("Images loaded")
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20,),
//
//             imageValue.isEmpty ?
//               const Text("No image")
//               : SizedBox(
//                 height: 400,
//                 child: Image.memory(imageValue)
//             ),
//
//             const SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
//               child: Row(
//                 children: <Widget>[
//                   const SizedBox(
//                     width: 200,
//                     child: Text(
//                       'Article content [html]',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () => uploadHtml(),
//                     style: ButtonStyle(
//                       padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
//                       textStyle: MaterialStateProperty.all(
//                         const TextStyle(fontSize: 16),
//                       ),
//                       backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.file_upload),
//                         SizedBox(width: 10),
//                         Text('Upload Article')
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                       child: htmlValue.isEmpty ? const Text("Please type article html.") : const Text("Article loaded.")
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20,),
//             Container(
//               height: 600,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               // color: ColorApp.grey_divider,
//               child: TextField(
//                 onTap: () {
//                   // debugPrint("Article html: ${htmlEditingController.text}");
//                 },
//                 controller: htmlEditingController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   hintText: 'Article content [html]',
//                   fillColor: CupertinoColors.secondarySystemFill,
//                   filled: true,
//                   hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
//                 ),
//                 cursorColor: Colors.black,
//                 maxLines: 1000,
//                 style: const TextStyle(color: ColorApp.grey_font),
//                 // expands: true,
//               ),
//             ),
//
//             const SizedBox(height: 20,),
//           ],
//         ),
//       ),
//     );
//   }
//
//   uploadImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         imageValue = file.bytes!;
//       });
//
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   uploadHtml() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       withData: true,
//       type: FileType.custom,
//       allowedExtensions: ['txt', 'html']);
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         htmlValue = file.bytes!;
//         htmlEditingController.text = "";
//         for(var i=0 ; i < htmlValue.buffer.asByteData().lengthInBytes; i++) {
//           htmlEditingController.text = htmlEditingController.text + String.fromCharCode(htmlValue.buffer.asByteData().getUint8(i));
//         }
//       });
//
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   String getStringFromBytes(ByteData data) {
//     final buffer = data.buffer;
//     var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     return utf8.decode(list);
//   }
//
// }
