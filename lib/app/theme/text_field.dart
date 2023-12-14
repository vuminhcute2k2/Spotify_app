import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyTextField extends StatelessWidget {
  final String lable;
  final IconData icons;
  final TextEditingController onChange;

  const MyTextField({super.key, required this.lable, required this.icons, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          // onChanged:(value){
                          //   //registerController.fullname;
                          // },
                          controller:onChange,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon:Icon(icons),
                            hintText: lable,
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
  }
}