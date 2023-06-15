import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heyva_web_admin/app/modules/home/controllers/menu_controller.dart';
import 'package:heyva_web_admin/app/modules/home/model/create_article_data.dart';
import 'package:heyva_web_admin/constant/colors.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import '../services/create_client.dart';
import 'admin_common.dart';

class TagList {
  int id;
  String name;

  TagList({required this.id, required this.name});
}

class CreateArticlePage extends GetView<CreateController> {
  CreateArticlePage({Key? key}) : super(key: key);
  static CreateController createCtrl = Get.find<CreateController>();
  final _formKey = GlobalKey<FormFieldState>();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  String attachmentId = '';
  String articleId = '';
  late List<String?> tagNames;
  late List<TagIdName>? tagIdNames;
  late List<String?> selectedNames;
  // var tagList = <TagList> [];

  void initTags() async {
    tagIdNames = await createCtrl.initArticleTagsList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.newArticle.index];
    final List<String> selectionMode = ['Development', 'Production'];

    if(createCtrl.tagIdNames.isEmpty) {
      initTags();
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // It may need to wait till GET ARTICLE INTEREST TAGS list completed :: gotTagsList is true
        // isGettingTags: whether getting tags list in progress
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
                createCtrl.isPostingReady.value
                  ? ElevatedButton(
                  onPressed: () async {
                    articleId = await createCtrl.postCreateArticle(attachmentId);
                    if(articleId.isNotEmpty) {
                      createCtrl.clearCreatePage();
                      articleId = '';
                      attachmentId = '';
                      debugPrint('Posting article DONE !');
                      // Launch a snackbar message
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
                )
                  : ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: MaterialStateProperty.all(ColorApp.btn_grey),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Text('Compose')
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 100,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: TitleField(),
                    child: SizedBox(
                      height: 30,
                      // width: 40,
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hint: const Text('Select Job Mode'),
                        value: createCtrl.selectedMode.value.isEmpty ? null : createCtrl.selectedMode.value,
                        onChanged: (newValue) {
                          if(attachmentId.isEmpty) {
                            createCtrl.selectedMode.value = newValue!;
                          }
                        },
                        style: const TextStyle(fontSize: 14, color: ColorApp.white_font),
                        focusColor: ColorApp.btn_pink,
                        dropdownColor: ColorApp.btn_pink,
                        borderRadius: BorderRadius.circular(10),
                        items: selectionMode.map((choice) {
                          return DropdownMenuItem(
                            value: choice,
                            child: Text(choice, style: const TextStyle(color: ColorApp.white_font),),
                          );
                        }).toList(),
                      ),
                    ),
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
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (text) {
                          createCtrl.updateReadiness();
                        },
                        controller: createCtrl.titleCtrl,
                        textAlignVertical: TextAlignVertical.bottom,
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
                ),
              ],
            ),
            // const SizedBox(height: 20,),
            // Multi-select chips for interest article tags selection
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
                const SizedBox(width: 10,),
                Expanded(
                  child: MultiSelectBottomSheetField<TagIdName?>(
                    key: _multiSelectKey,
                    initialChildSize: 0.7,
                    maxChildSize: 0.95,
                    title: const Text("Interest Tags", style: TextStyle(color: ColorApp.grey_font),),
                    buttonText: const Text("Selected Tags", style: TextStyle(color: ColorApp.grey_font),),
                    items: createCtrl.items.value,
                    searchable: true,
                    selectedColor: ColorApp.btn_pink,
                    // selectedItemsTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: ColorApp.white),
                    selectedItemsTextStyle: const TextStyle(color: ColorApp.btn_pink),
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return "Required";
                      }
                      // return null;
                    },
                    onConfirm: (values) {
                      createCtrl.selectedTags.value = values;
                      _multiSelectKey.currentState!.validate();
                      createCtrl.updateSelectedTagsId();
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      // items: createCtrl.selectedTags.value.map((item) => MultiSelectItem<TagIdName>(item!, item.name)).toList(),
                      chipColor: ColorApp.btn_pink,
                      textStyle: const TextStyle(color: ColorApp.white_font),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      onTap: (item) {
                        createCtrl.selectedTags.value.remove(item);
                        _multiSelectKey.currentState!.validate();
                        createCtrl.updateSelectedTagsId();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),

            const SizedBox(height: 20,),

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
                        if(createCtrl.selectedMode.value.isNotEmpty) {
                          await createCtrl.getAttachmentId();
                          attachmentId = createCtrl.attachmentId.value;
                          if (attachmentId.isEmpty) {
                            // Error handler
                          }
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
            // const SizedBox(height: 20,),
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
                  createCtrl.updateReadiness();
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
