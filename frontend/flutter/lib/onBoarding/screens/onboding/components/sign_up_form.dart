import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenith/pages/bodypage.dart';
import 'package:zenith/pages/homepage.dart';
import 'package:zenith/services/auth_services.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final AuthServices authService = AuthServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  // String? email;
  late SMITrigger confetti;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singup(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    // confetti.fire();
    context.loaderOverlay.show();
    await authService.signUp(
      context: context,
      name: name,
      email: email,
      password: password,
    );
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // print(email.value.text);
                        singup(
                          context,
                          email.text,
                          password.text,
                          name.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF77D8E),
                        minimumSize: const Size(double.infinity, 56),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                        ),
                      ),
                      icon: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xFFFE0037),
                      ),
                      label: const Text("Sign up"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isShowLoading
              ? CustomPositioned(
                  child: RiveAnimation.asset(
                    'assets/RiveAssets/check.riv',
                    fit: BoxFit.cover,
                    onInit: _onCheckRiveInit,
                  ),
                )
              : const SizedBox(),
          isShowConfetti
              ? CustomPositioned(
                  scale: 6,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: _onConfettiRiveInit,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
