import 'package:chattify/Bloc/ChatBloc/ChatBloc.dart';
import 'package:chattify/Bloc/ChatBloc/ChatEvent.dart';
import 'package:chattify/Bloc/ChatBloc/ChatState.dart';
import 'package:chattify/Model/ContactModel/ContactModel.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:chattify/res/components/ContactDisplayComp/contactDisplayComp.dart';
import 'package:chattify/res/components/CustomizedFeilds/CustomizedFeilds.dart';
import 'package:chattify/res/components/ShimmerEffects/ShimmerEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatLoadedEvent());
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
          'Chattify',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mw * 0.03,
            ),
            child: CustomizedFeild(
              hint: 'Search Chats...',
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
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoadingState) {
                return const ShimmerEffect();
              } else if (state is ChatSuccessState) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return context.read<ChatBloc>().add(ChatLoadedEvent());
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: state.model.length,
                      itemBuilder: (context, index) {
                        final ContactModel model = state.model[index];
                        return ContactDisplayComp(
                          image: model.image,
                          name: model.username,
                          status: model.status,
                          onContacttap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesNames.chatMessageScreen,
                              arguments: model,
                            );
                          },
                          onContactProfiletap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesNames.contactProfileScreen,
                              arguments: model,
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              } else if (state is ChatFailureState) {
                return Center(
                  child: Text(
                    state.errorMsg,
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
