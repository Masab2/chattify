import 'package:chattify/Bloc/AuthBloc/LoginBloc/loginBloc.dart';
import 'package:chattify/Bloc/AuthBloc/SignUpBloc/signUpBloc.dart';
import 'package:chattify/Bloc/ChatBloc/ChatBloc.dart';
import 'package:chattify/Bloc/ChatBloc/ChatMessagesBloc/ChatMessageBloc.dart';
import 'package:chattify/Bloc/ContactBloc/AddToChatBloc/addToChatBloc.dart';
import 'package:chattify/Bloc/ContactBloc/ContactBloc.dart';
import 'package:chattify/Bloc/Cubit/BottomnavBarCubit/BottomNavBarCubit.dart';
import 'package:chattify/Bloc/ImagePickerBloc/imagePickerBloc.dart';
import 'package:chattify/Bloc/ProfileBloc/ProfileBloc.dart';
import 'package:chattify/Bloc/UpdateProfile/UpdateProfileBloc.dart';
import 'package:chattify/Utils/Color/AppColor.dart';
import 'package:chattify/Utils/ImagePickerUtils/ImagePickerUtils.dart';
import 'package:chattify/Utils/extenshion/extenshion.dart';
import 'package:chattify/firebase_options.dart';
import 'package:chattify/res/Routes/routes.dart';
import 'package:chattify/res/Routes/routesname.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
        BlocProvider<ContactBloc>(create: (context) => ContactBloc()),
        BlocProvider<ImagePickerBloc>(
            create: (context) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
        BlocProvider<AddToChatBloc>(create: (context) => AddToChatBloc()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
        BlocProvider<ChatMessageBloc>(create: (context) => ChatMessageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chattify',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.secondaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.primaryColor,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.poppins(
              fontSize: context.mh * 0.025,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryColor,
            ),
            centerTitle: true,
          ),
          useMaterial3: true,
        ),
        initialRoute: RoutesNames.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
