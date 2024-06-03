import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/authentification_bloc/authentification_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
import 'package:kourti_application_1/home/Profile/EditProfileValues.dart';
import 'package:user_repository/user_repository.dart';

class EditProfile extends StatefulWidget {
  final MyUsers myUser;
  const EditProfile(this.myUser, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late MyUsers User;

  @override
  void initState() {
    User = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text("Edit Profile"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 95, 95, 95),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                User.Nom,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<SetUserDataBloc>(
                                          create: (context) => SetUserDataBloc(
                                            myUserRepository: context.read<AuthentificationBloc>().userRepository
                                          ),
                                          child: EditNom(User),
                                        ),
                                      )
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: const Color.fromARGB(255, 95, 95, 95),
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 95, 95, 95),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                User.E_mail,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<SetUserDataBloc>(
                                          create: (context) => SetUserDataBloc(
                                            myUserRepository: context.read<AuthentificationBloc>().userRepository
                                          ),
                                          child: EditEmail(User),
                                        ),
                                      )
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: const Color.fromARGB(255, 95, 95, 95),
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 95, 95, 95),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                User.Telephone,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<SetUserDataBloc>(
                                          create: (context) => SetUserDataBloc(
                                            myUserRepository: context.read<AuthentificationBloc>().userRepository
                                          ),
                                          child: EditPhone(User),
                                        ),
                                      )
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: const Color.fromARGB(255, 95, 95, 95),
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 95, 95, 95),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Password",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<SetUserDataBloc>(
                                          create: (context) => SetUserDataBloc(
                                            myUserRepository: context.read<AuthentificationBloc>().userRepository
                                          ),
                                          child: EditPassword(User),
                                        ),
                                      )
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: const Color.fromARGB(255, 95, 95, 95),
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 110,)
            ],
          ),
        ),
      ),
    );
  }
}
