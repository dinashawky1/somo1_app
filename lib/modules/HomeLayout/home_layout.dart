import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/shared/cubit.dart';
import 'package:somo1_app/shared/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('News Feed'),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context) {
                var model = SocialCubit.get(context).model;

                return Column(
                  children: [
                    if (!model!.isEmailVerified)
                      Container(
                        color: Colors.amber[300],
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline),
                                SizedBox(width: 15.0),
                                Text('please verify your email'),
                                SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                    onPressed: () {}, child: Text('SEND')),
                              ],
                            )),
                      ),
                  ],
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
