import 'dart:typed_data';
import 'dart:html' as html;
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heyva_web_admin/app/modules/home/controllers/menu_controller.dart';
import 'package:heyva_web_admin/app/modules/home/model/create_article_data.dart';
import 'package:heyva_web_admin/constant/colors.dart';
import '../services/admin_client.dart';
import 'admin_common.dart';


class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({Key? key}) : super(key: key);

  @override
  _CreateArticlePage createState() => _CreateArticlePage();
}


class _CreateArticlePage extends State<CreateArticlePage> {
  final createController = Get.put(CreateController(), permanent: true);
  Uint8List imageValue = Uint8List(0);
  Uint8List htmlValue = Uint8List(0);

  final _pickedImages = <Image>[];
  late String attArticleId;
  late String postedArticleId;
  // late final Image _imageWidget;
  // late html.File _cloudFile;
  late String fileName;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.newArticle.index];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  pageName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 120,),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ButtonStyle(
                //     padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                //     textStyle: MaterialStateProperty.all(
                //       const TextStyle(fontSize: 16),
                //     ),
                //     backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                //     shape: MaterialStateProperty.all(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                //   child: const Text('Compose'),
                // ),
                // const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () async {
                    // check if all required information ready
                    //  - article id :: got when post create attachment and this state reps. photo uploaded already
                    //  - article Title
                    //  - article Category :: tags
                    //  - date <> it may use system date time rather than selecting date from calendar
                    //  - article content [html]

                    if(attArticleId.isNotEmpty) {
                      if(createController.titleCtrl != null) {
                        if(createController.htmlCtrl != null) {
                          await createController.postCreateArticle(attArticleId);
                          postedArticleId = createController.articleId.value;
                          if(postedArticleId.isNotEmpty) {
                            createController.clearCreatePage();
                            setState(() {
                              imageValue = Uint8List(0);
                              htmlValue = Uint8List(0);
                              debugPrint('Posting article DONE !');
                            });
                          }
                        }
                      }
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Text('Submit')
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleField(),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      onChanged: (text) {
                        // debugPrint("Article title: ${titleEditingController.text}");
                      },
                      controller: createController.titleCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Article title',
                        fillColor: CupertinoColors.secondarySystemFill,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                      ),
                      cursorColor: ColorApp.grey_font,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      onChanged: (text) {
                        // debugPrint("Article category: ${categoryEditingController.text}");
                      },
                      controller: createController.categoryCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Article category',
                        fillColor: CupertinoColors.secondarySystemFill,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                      ),
                      cursorColor: ColorApp.grey_font,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SelectDate(controller: createController.dateCtrl,),
                  ),
                ),
              ],
            ),

            // the following may use Obx mechanism instead of setState
            Padding(
              padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  createController.isSelectedImage ?
                    createController.gotAttachmentId.value ?
                      ElevatedButton(
                        onPressed: () {
                          createController.clearPhotoAndId();
                          setState(() {
                            imageValue = Uint8List(0);
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16),
                          ),
                          backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Row(
                          children: <Widget>[
                            Icon(Icons.delete),
                            SizedBox(width: 5),
                            Text('Cancel')
                          ],
                        ),
                      )
                      : ElevatedButton(
                      onPressed: () async {
                        await createController.postGetArticleId();
                        attArticleId = createController.attachmentId.value;
                        if(attArticleId.isNotEmpty) {
                          setState(() {
                            // debugPrint('Getting pregnant tag: ${tagsList['getting pregnant']}');
                          });
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.app_registration),
                          SizedBox(width: 5),
                          Text('Request Id')
                        ],
                      ),
                    )
                    : ElevatedButton(
                      onPressed: () async {
                        var fileName = await createController.selectImage();
                        if(fileName != null) {
                          setState(() {
                            imageValue = createController.imageBytes;
                          });
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.file_upload),
                          SizedBox(width: 5),
                          Text('Select Photo')
                        ],
                      ),
                    ),
                  const SizedBox(width: 20),
                  createController.isSelectedImage ?
                          createController.gotAttachmentId.value ?
                            const Text('')
                            : ElevatedButton(
                            onPressed: () async {
                              createController.clearPhotoAndId();
                              var fileName = await createController.selectImage();
                              if(fileName != null) {
                                setState(() {
                                  imageValue = createController.imageBytes;
                                });
                              }
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 16),
                              ),
                              backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(Icons.file_upload),
                                SizedBox(width: 5),
                                Text('Change Photo')
                              ],
                            ),
                          )
                      : const Text(''),
                  Expanded(
                    child: createController.gotAttachmentId.value ? Text('Id: ${createController.attachmentId}') : const Text(""),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            // imageValue.isEmpty ?
            createController.imageBytes.isEmpty ?
              const Text("Press to select photo.", style: TextStyle(color: ColorApp.grey_container),)
              : SizedBox(
                height: 400,
                width: width / 2,
                // child: Image.memory(imageValue)
                child: Image.memory(createController.imageBytes),
              ),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Article content',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      htmlValue = (await createController.uploadHtml())!;
                      if(htmlValue.isNotEmpty) {
                        setState(() {
                          createController.htmlCtrl.text = "";
                          for(var i=0 ; i < htmlValue.buffer.asByteData().lengthInBytes; i++) {
                            createController.htmlCtrl.text = createController.htmlCtrl.text + String.fromCharCode(htmlValue.buffer.asByteData().getUint8(i));
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: MaterialStateProperty.all(ColorApp.btn_pink),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.file_upload),
                        SizedBox(width: 5),
                        Text('Upload Article')
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: htmlValue.isEmpty ?
                        const Text("Upload or edit article html.", style: TextStyle(color: ColorApp.grey_container),)
                        : const Text("Loaded!")
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 600,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // color: ColorApp.grey_divider,
              child: TextField(
                onTap: () {
                  // debugPrint("Article html: ${htmlEditingController.text}");
                },
                controller: createController.htmlCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Article content [html]',
                  fillColor: CupertinoColors.secondarySystemFill,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black12, fontStyle: FontStyle.italic),
                ),
                cursorColor: Colors.black,
                maxLines: 1000,
                style: const TextStyle(color: ColorApp.grey_font),
                // expands: true,
              ),
            ),

            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
