import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatBloc.dart';
import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatEvent.dart';
import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatState.dart';
import 'package:chattify/Bloc/ContactBloc/ContactBloc.dart';
import 'package:chattify/Bloc/ContactBloc/ContactEvent.dart';
import 'package:chattify/Bloc/ContactBloc/ContactState.dart';
import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/Utils/utils.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:chattify/res/components/ContactDisplayComp/contactDisplayComp.dart';
import 'package:chattify/res/components/CustomizedFeilds/CustomizedFeilds.dart';
import 'package:chattify/res/components/ShimmerEffects/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreenView extends StatefulWidget {
  const ContactScreenView({super.key});

  @override
  State<ContactScreenView> createState() => _ContactScreenViewState();
}

class _ContactScreenViewState extends State<ContactScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(ContactLoadedEvent());
  }

  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts Info',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03,
            ),
            child: CustomizedFeild(
              hint: 'Search User...',
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColor.primaryColor,
              ),
              controller: searchController,
              validator: (p0) {
                return null;
              },
            ),
          ),
          0.02.ph(context),
          BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactLoadingState) {
                return const ShimmerEffect();
              } else if (state is ContactSuccessState) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return context
                          .read<ContactBloc>()
                          .add(ContactLoadedEvent());
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: state.contactModel.length,
                      itemBuilder: (context, index) {
                        final ContactModel model = state.contactModel[index];
                        return BlocListener<AddToChatBloc, AddToChatState>(
                          listener: (context, addContactstate) {
                            if (state is AddToChatSuccessState) {
                              Utils.showBlurDialog(
                                  context,
                                  'Successfully Added',
                                  'Contact Is Added To Chat',
                                  'Cancel',
                                  'OK');
                            } else if (state is AddToChatFailureState) {
                              Utils.showBlurDialog(
                                  context, 'Error', 'Errro', 'Cancel', 'OK');
                            }
                          },
                          child: ContactDisplayComp(
                            image: state.contactModel[index].image,
                            name: state.contactModel[index].username,
                            status: state.contactModel[index].status,
                            onContacttap: () {
                              context.read<AddToChatBloc>().add(
                                    AddToChatCollectionEvent(model),
                                  );
                            },
                            onContactProfiletap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesNames.contactProfileScreen,
                                arguments: model,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is ContactErrorState) {
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
          )
        ],
      ),
    );
  }
}
