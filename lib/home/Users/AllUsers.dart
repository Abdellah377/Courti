// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/get_users_bloc/get_users_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/log_in_bloc/log_in_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/my_user_bloc/my_user_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/home/Profile/MyProfile_Screen.dart';
import 'package:kourti_application_1/home/Users/UserProfile_Screen.dart';
import 'package:kourti_application_1/home/Users/SearchUsers_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final _formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();
  late String ArgsController = 'Nom';

  List<String> listOfValue = ['Nom', 'Type', 'Telephone', 'E_mail'];

  late AppLanguageProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.translate('Users')!),

        leading: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.person_pin),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: MyProfile_Screen(state.myUser!),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            );
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                context.read<LogInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Form(
            key: _formKey,
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  decoration: BoxDecoration(
                      border:
                          const Border(bottom: BorderSide(color: Colors.black)),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(15)),
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(.2)),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    value: ArgsController,
                    hint: const Text(
                      'Nom',
                    ),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        ArgsController = value!;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        ArgsController = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == '') {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    items: listOfValue.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border:
                          const Border(bottom: BorderSide(color: Colors.black)),
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(.2),
                    ),
                    child: TextFormField(
                      style: const TextStyle(height: 1.5),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.translate('Search User')!,
                      ),
                      controller: valueController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('value is required')!;
                        }
                        return null;
                      },
                    )
                  ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(15)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SearchUser_Screen(ArgsController, valueController.text),
                          withNavBar: false,
                          pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                        );
                      },
                    )
                  ),
                ),
              ],
            )
          ),
          const SizedBox(height: 30,),
          Builder(builder: (context) {
            return BlocBuilder<GetUsersBloc, GetUsersState>(
              builder: (context, state) {
                if (state is GetUsersSuccess) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.myUsers.length,
                      itemBuilder: (context, int i) {
                        return MaterialButton(
                          padding: const EdgeInsets.only(left: 0),
                          onPressed: () { 
                            PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: UserProfile_Screen(state.myUsers[i]),
                            withNavBar: false,
                            pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                        );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: state.myUsers[i].picture == ""
                                    ? Container(
                                        width: 95,
                                        height: 95,
                                        decoration: const BoxDecoration(
                                            color: Colors.amber, shape: BoxShape.circle),
                                      )
                                    : Container(
                                        width: 95,
                                        height: 95,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(state.myUsers[i].picture),
                                                fit: BoxFit.cover)),
                                      ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.myUsers[i].Nom,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        Text(
                                          state.myUsers[i].Type,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        Text(
                                          state.myUsers[i].Telephone,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 106, 106, 106)),
                                        ),
                                        Text(
                                          state.myUsers[i].E_mail,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 106, 106, 106)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      });
                } else if (state is GetUsersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Error!!!",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
              },
            );
          }),
        ],
      )),
    );
  }
}
