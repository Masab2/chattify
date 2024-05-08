import 'dart:developer';
import 'dart:io';

import 'package:chattify/Bloc/ImagePickerBloc/ImagePickerEvent.dart';
import 'package:chattify/Bloc/ImagePickerBloc/ImagePickerState.dart';
import 'package:chattify/Bloc/ImagePickerBloc/imagePickerBloc.dart';
import 'package:chattify/Bloc/UpdateProfile/UpdateProfileBloc.dart';
import 'package:chattify/Bloc/UpdateProfile/updateProfileEvent.dart';
import 'package:chattify/Bloc/UpdateProfile/updateProfileState.dart';
import 'package:chattify/Model/ProfileModel/ProfileModel.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/Utils/utils.dart';
import 'package:chattify/res/components/ResueAbleBtn/ReuseAbleBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class UpdateProfile extends StatefulWidget {
  final ProfileModel args;
  const UpdateProfile({super.key, required this.args});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    statusController.text = widget.args.status;
    super.initState();
  }

  @override
  void dispose() {
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, imagestate) {
          return Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.greyColor,
                          width: context.mh * 0.002,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(context.mh * 0.15),
                        child:
                            imagestate.file == null
                                ? Icon(
                                    IconlyBold.profile,
                                    color: AppColor.primaryColor,
                                    size: context.mh * 0.140,
                                  )
                                : Image.file(
                                    height: context.mh * 0.20,
                                    width: context.mw * 0.40,
                                    fit: BoxFit.cover,
                                    File(imagestate.file!.path),
                                  ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: context.mw * 0.26,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mw * 0.03,
                        vertical: context.mh * 0.03,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor.withOpacity(0.75),
                      ),
                      child: InkWell(
                        onTap: () {
                          Utils.showDialogImage(
                            context,
                            'Select Options',
                            () {
                              log('OnCamera');
                              BlocProvider.of<ImagePickerBloc>(context)
                                  .add(CameraCapture());
                            },
                            () {
                              log('OnGalllery');
                              BlocProvider.of<ImagePickerBloc>(context)
                                  .add(GalleryPicker());
                            },
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          size: context.mh * 0.030,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              0.03.ph(context),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.mw * 0.04,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    0.01.ph(context),
                    TextFormField(
                      controller: statusController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.primaryColor,
                            )),
                        hintText: 'Update Your Status',
                      ),
                    ),
                  ],
                ),
              ),
              0.03.ph(context),
              BlocListener<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccessState) {
                    Utils.showBlurDialog(
                      context,
                      'Profile Updated',
                      'Your Profile is UptoDate',
                      'Cancel',
                      'OK',
                    );
                  } else if (state is UpdateProfileFailureState) {
                    Utils.showBlurDialog(
                      context,
                      'Error Occured',
                      state.errormsg,
                      'Cancel',
                      'OK',
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.mw * 0.03,
                    vertical: context.mh * 0.02,
                  ),
                  child: Btn(
                    title: 'Update Profile',
                    ontap: () {
                      log('Pressed');
                      BlocProvider.of<UpdateProfileBloc>(context).add(
                        ProfileUpdateEvent(
                          fileUrl: imagestate.file!.path.toString(),
                          status: statusController.text,
                        ),
                      );
                    },
                    width: context.mw,
                    height: context.mh * 0.06,
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
