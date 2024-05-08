import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattify/Bloc/ProfileBloc/ProfileBloc.dart';
import 'package:chattify/Bloc/ProfileBloc/ProfileEvent.dart';
import 'package:chattify/Bloc/ProfileBloc/ProfileState.dart';
import 'package:chattify/Model/ProfileModel/ProfileModel.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/Utils/utils.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:chattify/res/components/ResueAbleBtn/ReuseAbleBtn.dart';
import 'package:chattify/res/components/UserInfoListTile/UserInfoListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.10.ph(context),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      0.40.ph(context),
                      Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColor.greyColor,
                        ),
                      ),
                    ],
                  );
                } else if (state is ProfileSuccessState) {
                  ProfileModel profileModel = state.profileModel.first;
                  return Column(
                    children: [
                      Container(
                        padding: profileModel.image == ''
                            ? EdgeInsets.symmetric(
                                horizontal: context.mw * 0.03,
                                vertical: context.mh * 0.02,
                              )
                            : null,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.greyColor,
                            width: context.mh * 0.002,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(context.mh * 0.15),
                          child: profileModel.image == ''
                              ? Icon(
                                  IconlyBold.profile,
                                  color: AppColor.primaryColor,
                                  size: context.mh * 0.130,
                                )
                              : CachedNetworkImage(
                                  height: context.mh * 0.20,
                                  width: context.mw * 0.40,
                                  fit: BoxFit.cover,
                                  imageUrl: profileModel.image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                        ),
                      ),
                      0.01.ph(context),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Btn(
                          title: 'Update Profile',
                          ontap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesNames.updateProfileScreen,
                              arguments: profileModel,
                            );
                          },
                          width: context.mw * 0.50,
                          height: context.mh * 0.04,
                        ),
                      ),
                      0.03.ph(context),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.mw * 0.02),
                        child: Column(
                          children: [
                            UserInfoListTile(
                                icon: IconlyBold.user_2,
                                title: 'UserName`',
                                subtitle: state.profileModel.first.username),
                            0.01.ph(context),
                            UserInfoListTile(
                                icon: IconlyBold.message,
                                title: 'Email Address',
                                subtitle: state.profileModel.first.email),
                            0.01.ph(context),
                            UserInfoListTile(
                                icon: Icons.event_available_outlined,
                                title: 'About',
                                subtitle: state.profileModel.first.status),
                            0.01.ph(context),
                            UserInfoListTile(
                                icon: IconlyBold.call,
                                title: 'Phone No',
                                subtitle: state.profileModel.first.phone),
                            0.01.ph(context),
                            LogOutListTile(
                              icon: IconlyBold.logout,
                              title: 'LogOut',
                              ontap: () {
                                Utils.showBlurDialog(context, 'LogOut',
                                    'Are you Sure', 'No', 'Yes');
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is ProfileErrorState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
