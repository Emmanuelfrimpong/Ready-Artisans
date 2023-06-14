import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_artisans_admin/Components/custom_button.dart';
import 'package:ready_artisans_admin/Components/smart_dialog.dart';
import 'package:ready_artisans_admin/Database/firebase_api.dart';
import 'package:ready_artisans_admin/Models/category_model.dart';
import 'package:ready_artisans_admin/utils/app_colors.dart';
import '../../../Components/custom_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? serviceTitle;
  String? serviceDescription;
  XFile? serviceImage;
  final _formKey = GlobalKey<FormState>();
  final _serviceTitleController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseApi.getCategories(),
        builder: (context, snapshot) {
          List<CategoryModel> categoryList = [];
          if (snapshot.hasData && snapshot.data != null) {
            for (var element in snapshot.data!.docs) {
              categoryList.add(CategoryModel.fromMap(
                  element.data() as Map<String, dynamic>));
            }
            if (kDebugMode) {
              print('length of category list: ${categoryList.length}');
            }
          }
          return LayoutBuilder(builder: (context, constraints) {
            return Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    width: size.width,
                    height: size.width > 800 ? 100 : 30,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(children: [
                      if (size.width <= 800)
                        Text(
                          'Home/Settings',
                          style: GoogleFonts.nunito(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      if (size.width > 800)
                        Image.asset(
                          'assets/images/logo_h_t.png',
                        ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Spacer(),
                      if (size.width > 800)
                        Text(
                          'Home/Settings',
                          style: GoogleFonts.nunito(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Services Categories',
                            style: GoogleFonts.poppins(
                                color: Colors.black45,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          if (constraints.maxWidth <= 800)
                            smallScreen(
                                snapshot: snapshot, categoryList: categoryList)
                          else
                            largeScreen(
                                snapshot: snapshot, categoryList: categoryList)
                        ],
                      ),
                    ),
                  )
                ])));
          });
        });
  }

  Widget smallScreen(
      {AsyncSnapshot<QuerySnapshot<Object?>>? snapshot,
      List<CategoryModel>? categoryList}) {
    var size = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black45,
          )),
          width: size,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomTextFields(
                label: 'Category Title',
                controller: _serviceTitleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Category Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    serviceTitle = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                label: 'Category description',
                maxLines: 3,
                controller: _serviceDescriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Category Description';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    serviceDescription = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select an image for this Category',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500, color: Colors.black45),
              ),
              Row(children: [
                CustomButton(
                    color: Colors.grey,
                    onPressed: () {
                      pickImage();
                    },
                    text: 'Upload Image'),
                const SizedBox(
                  width: 10,
                ),
                if (serviceImage != null)
                  Image.network(
                    serviceImage!.path,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
              ]),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                onPressed: () {
                  saveCategory();
                },
                text: 'Save Category',
              )
            ]),
          ),
        ),
        snapshot!.connectionState == ConnectionState.waiting
            ? const Expanded(
                child: Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black45,
                )),
                width: size,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryList!.length,
                    itemBuilder: (context, index) {
                      CategoryModel cat = categoryList[index];

                      return InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.black45,
                            ))),
                            child: ListTile(
                                leading: Image.network(
                                  cat.image!,
                                  width: 60,
                                  height: 60,
                                ),
                                trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      CustomDialog.showInfo(
                                        title: 'Delete',
                                        message:
                                            'Are you sure you want to delete this category?',
                                        onConfirmText: 'Delete',
                                        onConfirm: () {
                                          deleteCategory(cat.id!);
                                        },
                                      );
                                    }),
                                title: Text(
                                  cat.name!,
                                  style:
                                      GoogleFonts.nunito(color: Colors.black),
                                )),
                          ),
                          onTap: () {
                            setState(() {});
                          });
                    }),
              ),
      ],
    );
  }

  Widget largeScreen(
      {AsyncSnapshot<QuerySnapshot<Object?>>? snapshot,
      List<CategoryModel>? categoryList}) {
    var size = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black45,
          )),
          width: size * .5,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomTextFields(
                label: 'Category Title',
                controller: _serviceTitleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Category Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    serviceTitle = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                label: 'Category description',
                maxLines: 3,
                controller: _serviceDescriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Category Description';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    serviceDescription = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select an image for this Category',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500, color: Colors.black45),
              ),
              Row(children: [
                CustomButton(
                    color: Colors.grey,
                    onPressed: () {
                      pickImage();
                    },
                    text: 'Upload Image'),
                const SizedBox(
                  width: 10,
                ),
                if (serviceImage != null)
                  Image.network(
                    serviceImage!.path,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
              ]),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                color: secondaryColor,
                onPressed: () {
                  saveCategory();
                },
                text: 'Save Category',
              )
            ]),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        snapshot!.connectionState == ConnectionState.waiting
            ? const Expanded(
                child: Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black45,
                )),
                width: size * .4,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryList!.length,
                    itemBuilder: (context, index) {
                      CategoryModel cat = categoryList[index];

                      return InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.black45,
                            ))),
                            child: ListTile(
                                leading: Image.network(
                                  cat.image!,
                                  width: 60,
                                  height: 60,
                                ),
                                trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      CustomDialog.showInfo(
                                        title: 'Delete',
                                        message:
                                            'Are you sure you want to delete this category?',
                                        onConfirmText: 'Delete',
                                        onConfirm: () {
                                          deleteCategory(cat.id!);
                                        },
                                      );
                                    }),
                                title: Text(
                                  cat.name!,
                                  style:
                                      GoogleFonts.nunito(color: Colors.black),
                                )),
                          ),
                          onTap: () {
                            setState(() {});
                          });
                    }),
              ),
      ],
    );
  }

  pickImage() async {
    serviceImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 750,
        maxHeight: 750,
        preferredCameraDevice: CameraDevice.rear);
    setState(() {});
  }

  void saveCategory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (serviceImage == null) {
        CustomDialog.showError(
            title: 'Error', message: 'Category Image is required');
      } else {
        CustomDialog.showLoading(message: 'Saving category...Please wait');
        bool exist = await FirebaseApi.getCategoryByName(serviceTitle!);
        if (!exist) {
          String id = await FirebaseApi.getId('Categories');
          String? imagePath = await FirebaseApi.uploadImage(serviceImage!, id);
          if (imagePath == null) {
            CustomDialog.dismiss();
            CustomDialog.showError(
                title: 'Error',
                message: 'Something went wrong while uploading image');
            return;
          }
          CategoryModel category = CategoryModel(
              name: serviceTitle,
              description: serviceDescription,
              image: imagePath,
              id: id);
          var data = await FirebaseApi.addCategory(category);
          CustomDialog.dismiss();
          if (data != null) {
            if (data['status'] == true) {
              CustomDialog.showSuccess(
                  title: 'Success', message: 'Category Added Successfully');
            } else {
              CustomDialog.showError(title: 'Error', message: data['message']);
            }
          } else {
            CustomDialog.showError(
                title: 'Error', message: 'Something went wrong');
          }
        } else {
          CustomDialog.showError(
              title: 'Error',
              message: 'Category with the same name already exist');
        }
      }
    }
  }

  void deleteCategory(String s) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting category...Please wait');
    //delete category image
    await FirebaseApi.deleteImage(s);
    await FirebaseApi.deleteCategory(s).then((value) {
      CustomDialog.dismiss();
      if (value['status'] == true) {
        CustomDialog.dismiss();
        CustomDialog.showSuccess(
            title: 'Success', message: 'Category Deleted Successfully');
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(title: 'Error', message: value['message']);
      }
    });
  }
}
