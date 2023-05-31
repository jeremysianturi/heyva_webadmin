import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heyva_web_admin/app/modules/home/controllers/menu_controller.dart';
import 'package:heyva_web_admin/app/modules/home/model/create_article_data.dart';
import 'package:heyva_web_admin/constant/colors.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../login/controllers/login_controller.dart';
import '../services/admin_client.dart';
import 'admin_common.dart';

class TagList {
  int id;
  String name;

  TagList({required this.id, required this.name});
}

class CreateArticlePage extends GetView<CreateController> {
  CreateArticlePage({Key? key}) : super(key: key);
  // final createCtrl = Get.put(CreateController(), permanent: true);
  static CreateController createCtrl = Get.find<CreateController>();
  // final _formKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();

  String attachmentId = '';
  String articleId = '';
  late List<String?> tagNames;
  late List<TagIdName>? tagIdNames;
  late List<String?> selectedNames;
  var tagList = <TagList> [];
  var selectedTags =  <TagList> [];

  void initTags() async {
    tagIdNames = await createCtrl.initArticleTagsList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.newArticle.index];
    if(createCtrl.tagIdNames.isEmpty) {
      initTags();
      debugPrint('TEST');
    }
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: <Widget>[
            // Header admin page title and submit dispatching button
            Row(
              children: <Widget>[
                Text(
                  pageName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 64,),
                ElevatedButton(
                  onPressed: () async {
                    // check if all required information ready
                    //  - article id :: got when post create attachment and this state reps. photo uploaded already
                    //  - article Title
                    //  - article Category :: tags
                    //  - date <> it may use system date time rather than selecting date from calendar
                    //  - article content [html]
                    final _items = tagIdNames
                        ?.map((tag) => MultiSelectItem<TagIdName>(tag, tag.name))
                        .toList();
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
            // Article title field
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 160,
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
            // Article interest tags
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 160,
                  child: Text(
                    'Article Tags',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // this is just test requesting Interest Tags list
                // once confirmed this will be used for Multi_Select Chip
                ElevatedButton(
                  onPressed: () async {
                    tagIdNames = await createCtrl.initArticleTagsList();
                    for (var e in tagIdNames!) {
                      debugPrint('id: ${e.id.toString()}\nname: ${e.name.toString()}');
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
                      Text('Tags List')
                    ],
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
                        hintText: 'Select relevant tags',
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

            // Multi-select chips for tags selection

            // Date creation
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 160,
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
            // Photo selection
            Padding(
              padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 160,
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
                          attachmentId = '';
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
            // Photo widget container
            createCtrl.imageBytes.value.isEmpty ?
              const Text(
                "Press to select photo.",
                style: TextStyle(color: ColorApp.grey_container)
              )
              : SizedBox(
                height: 400,
                child: Row(
                  children: [
                    const SizedBox(width: 160,),
                    Expanded(
                      // height: 400,
                      // width: width / 2,
                      child: Image.memory(createCtrl.imageBytes.value),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20,),
            // Content html editing / selection field
            Padding(
              padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 160,
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
            // Html text field :: editable
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
