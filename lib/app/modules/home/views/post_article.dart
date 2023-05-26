import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heyva_web_admin/app/modules/home/controllers/menu_controller.dart';
import 'package:heyva_web_admin/constant/colors.dart';
import '../services/admin_client.dart';
import 'admin_common.dart';


class CreateArticlePage extends GetView<CreateController> {
  CreateArticlePage({Key? key}) : super(key: key);
  final createCtrl = Get.put(CreateController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  String attachmentId = '';
  String articleId = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.newArticle.index];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  pageName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 120,),
                ElevatedButton(
                  onPressed: () async {
                    // check if all required information ready
                    //  - article id :: got when post create attachment and this state reps. photo uploaded already
                    //  - article Title
                    //  - article Category :: tags
                    //  - date <> it may use system date time rather than selecting date from calendar
                    //  - article content [html]
                    if(attachmentId.isNotEmpty) {
                      articleId = await createCtrl.postCreateArticle(attachmentId);
                      if(articleId.isNotEmpty) {
                        createCtrl.clearCreatePage();
                        articleId = '';
                        attachmentId = '';
                        debugPrint('Posting article DONE !');
                        // Launch a snackbar message
                      }
                    } else {
                      // Launch a snackbar message
                      debugPrint('Please request attachment id first !');
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
                      },
                      controller: createCtrl.titleCtrl,
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
                      },
                      controller: createCtrl.categoryCtrl,
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
                    child: SelectDate(controller: createCtrl.dateCtrl,),
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
                  createCtrl.isSelectedImage ?
                    createCtrl.gotAttachmentId.value ?
                      ElevatedButton(
                        onPressed: () {
                          createCtrl.clearPhotoAndId();
                          // setState(() {
                            attachmentId = '';
                          // });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0)
                          ),
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
                        await createCtrl.getAttachmentId();
                        attachmentId = createCtrl.attachmentId.value;
                        if(attachmentId.isEmpty) {
                          // Error handler
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0)
                        ),
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
                        await createCtrl.selectImage();
                        if(createCtrl.imageFileName.isEmpty) {
                          // Launch a snackbar message
                          // Error handler
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0)
                        ),
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
                  createCtrl.imageFileName.isNotEmpty ?
                    Text(
                      createCtrl.imageFileName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    )
                    : const Text(''),

                  const SizedBox(width: 20),
                  createCtrl.isSelectedImage ?
                    createCtrl.gotAttachmentId.value ?
                      const Text('')
                      : ElevatedButton(
                        onPressed: () async {
                          createCtrl.clearPhotoAndId();
                          await createCtrl.selectImage();
                          if(createCtrl.imageFileName.isEmpty) {
                            // Launch a snackbar message
                            // Error handler
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0)
                          ),
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
                    child: createCtrl.gotAttachmentId.value ?
                      Text('Id: ${createCtrl.attachmentId}')
                      : const Text(""),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            createCtrl.imageBytes.value.isEmpty ?
              const Text(
                "Press to select photo.",
                style: TextStyle(color: ColorApp.grey_container)
              )
              : SizedBox(
                height: 400,
                width: width / 2,
                child: Image.memory(createCtrl.imageBytes.value),
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
                      await createCtrl.uploadHtml();
                      if(createCtrl.htmlBytes.value.isEmpty) {
                        // Launch a snackbar message
                        // Error handler
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      ),
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
                      child: createCtrl.htmlFileName.isEmpty ?
                        const Text(
                          "Upload or edit article html.",
                          style: TextStyle(color: ColorApp.grey_container),
                        )
                        : Text(
                          createCtrl.htmlFileName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          ),
                        )
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
                },
                controller: createCtrl.htmlCtrl,
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
              ),
            ),

            const SizedBox(height: 20,),
          ],
        ),
      ),
    ));
  }
}
