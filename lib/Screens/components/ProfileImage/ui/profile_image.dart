import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Screens/components/ProfileImage/cubit/profile_image_cubit.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class ProfileImage extends StatefulWidget {
  final String image;
  final double radius;
  final Color? backgroundColor;
  final Widget? imageErr;
  const ProfileImage({
    super.key,
    required this.image,
    this.radius = 20,
    this.backgroundColor,
    this.imageErr,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final cubit = ProfileImageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, bool>(
      bloc: cubit,
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (ctx, isErr) {
        return CircleAvatar(
          radius: widget.radius,
          backgroundColor: widget.backgroundColor ?? AppColor.kWhiteColor,

          /// !isError display image else null
          backgroundImage:
              isErr ? null : MemoryImage(base64Decode(widget.image)),

          /// the same 'backgroundImage' and 'onBackgroundImageError'
          /// if have value must have both
          onBackgroundImageError: isErr
              ? null
              : (exception, stackTrace) {
                  cubit.isError(true);
                },

          /// not error get null,
          child: !isErr
              ? null
              : widget.imageErr ??
                  Image(
                    image: const AssetImage('images/user_1.png'),
                    color: Colors.grey,
                    width: widget.radius,
                  ),
        );
      },
    );
  }
}
