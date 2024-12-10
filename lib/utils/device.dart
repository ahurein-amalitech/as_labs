import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AsDeviceUtils {
  AsDeviceUtils._();

  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getAdaptiveResponsivePadding(BuildContext context){
    double width  = AsDeviceUtils.getScreenWidth(context);
    return width > 600 ? width * 0.3 : 20.0;
  }

  static bool isMobile(){
    return GetPlatform.isMobile;
  }
}