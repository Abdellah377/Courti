// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/set_user_data_bloc/set_user_data_bloc.dart';
import 'package:kourti_application_1/Blocs/UserBlocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kourti_application_1/app_language_provider.dart';
import 'package:kourti_application_1/app_localizations.dart';
import 'package:kourti_application_1/auth/welcome_page.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

class Otp extends StatefulWidget {
  final MyUsers myuser;
  final bool verw;
  const Otp(this.myuser, this.verw,{super.key});

  @override
  State<Otp> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<Otp> {

  late bool ver;
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    ver = widget.verw;
    super.initState();
  }

  late AppLanguageProvider appLanguage;
  
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    appLanguage = Provider.of<AppLanguageProvider>(context);
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Welcome_page(),
                ));
          });
        } else if (state is SignUpLoading) {
          setState(() {
            // signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          Navigator.pop(context);
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/images_otp.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate('Phone Verification')!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.translate('Nous devons enregistrer votre téléphone pour commencer!')!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.translate("required input")!;
                      }
                      return null;
                    },
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        focusNode.unfocus();
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            if (ver == true) {
                              context.read<SignUpBloc>().add(SignUpRequired(
                              widget.myuser, otpController.text));
                            } else {
                              context.read<SetUserDataBloc>().add(VerSetPhone(widget.myuser, otpController.text));
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      color: Color(0xff0095FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        AppLocalizations.of(context)!.translate('Phone Verification')!,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.translate('Edit Phone Number ?')!,
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
