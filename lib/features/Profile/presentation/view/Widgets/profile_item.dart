import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';


class ProfileItem extends StatelessWidget {
  final String imagePath ; 
  final String label ; 
  final VoidCallback? onTap ; 
   ProfileItem({super.key, required this.imagePath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: onTap,
      child: Container(
        
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color:const  Color.fromRGBO(241, 241, 241, 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgIcon(path: imagePath, width: 50.w, height: 50.h,color:const  Color.fromRGBO(41, 45, 50, 1) ),
            SizedBox(
              height: 8.h,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 80.w
              ),
              child: Text(
                label,
                style: Styles.styles12w400black.copyWith(color: const Color.fromRGBO(41, 45, 50, 1),fontSize: 14.sp),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
        
              ),
            )
      
          ],
        ),
      ),
    );
  }
}