import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/get_users_bloc/get_users_bloc.dart';
import 'package:kourti_application_1/home/Users/UserProfile_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text("Users"),
        ),
        body: Column(
          children: [
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
        ));
  }
}
