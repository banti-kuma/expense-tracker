export 'dart:async';
export 'dart:convert';
export 'dart:io';

export 'package:expense_tracker/app/core/widget/custom_loader.dart';
/*============================================ third parties libraries ====================================*/

export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
export 'package:country_calling_code_picker/picker.dart';
export 'package:flutter_styled_toast/flutter_styled_toast.dart';
export 'package:fancy_shimmer_image/fancy_shimmer_image.dart';


/* =============================================dart, flutter and getx =====================================*/

export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart' hide DatePickerTheme;
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:get/get.dart'
    hide Response, HeaderValue, MultipartFile, FormData;
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';




/*================================================== application binding =====================================*/

export 'package:expense_tracker/app/bindings/initial_binding.dart';
export 'package:expense_tracker/app/bindings/local_source_bindings.dart';


/*=============================================== base exports =============================================*/

export 'package:expense_tracker/app/core/base/base_controller.dart';
export 'package:expense_tracker/app/core/base/base_view.dart';
export 'package:expense_tracker/app/core/base/page_state.dart';
export 'package:expense_tracker/app/core/utils/helper_widget.dart';
export 'package:expense_tracker/app/core/utils/validator.dart';
export 'package:expense_tracker/app/core/values/app_assets.dart';
export 'package:expense_tracker/app/core/values/app_colors.dart';
export 'package:expense_tracker/app/core/values/app_constants.dart';
export 'package:expense_tracker/app/core/values/app_strings.dart';
export 'package:expense_tracker/app/core/values/app_theme.dart';
export 'package:expense_tracker/app/core/values/app_values.dart';
export 'package:expense_tracker/app/core/widget/asset_image.dart';
export 'package:expense_tracker/app/core/widget/button_widget.dart';


/* ================================================app constants ===========================================*/

export 'package:expense_tracker/app/core/values/route_arguments.dart';
export 'package:expense_tracker/app/core/values/text_styles.dart';
export 'package:expense_tracker/app/core/widget/country_picker.dart';
export 'package:expense_tracker/app/core/widget/custom_appbar.dart';
export 'package:expense_tracker/app/core/widget/custom_flash_bar.dart';
export 'package:expense_tracker/app/core/widget/custom_inkwell.dart';

/*=================================================== widgets =============================================*/

export 'package:expense_tracker/app/core/widget/loading_widget.dart';
export 'package:expense_tracker/app/core/widget/annotated_region_widget.dart';
export 'package:expense_tracker/app/core/widget/edit_text_widget.dart';
export 'package:expense_tracker/app/core/widget/logout_dialog.dart';
export 'package:expense_tracker/app/core/widget/read_more_widget.dart';
export 'package:expense_tracker/app/core/widget/square_percent_indicator.dart';
export 'package:expense_tracker/app/core/widget/text_view.dart';
export 'package:expense_tracker/app/core/widget/time_formatter.dart';
export 'package:expense_tracker/app/core/widget/custom_date_picker/custom_date_picker_widget.dart';
export 'package:expense_tracker/app/core/widget/dropdown_text_Widget.dart';

/*==================================================== local services =====================================*/

export 'package:expense_tracker/app/data/local/preferences/theme_controller.dart';
export 'package:expense_tracker/app/data/local/preferences/database_manager.dart';

/* =========================================== Application bindings =====================================================*/

export 'package:expense_tracker/app/modules/splash/bindings/splash_binding.dart';
export 'package:expense_tracker/app/modules/authentication/bindings/congratulation_binding.dart';
export 'package:expense_tracker/app/modules/authentication/bindings/login_binding.dart';
export 'package:expense_tracker/app/modules/authentication/bindings/otp_verification_binding.dart';
export 'package:expense_tracker/app/modules/authentication/bindings/signup_binding.dart';
export 'package:expense_tracker/app/modules/home/bindings/home_binding.dart';
export 'package:expense_tracker/app/modules/home/bindings/add_expense_binding.dart';


/*============================================== application controllers =====================================*/

export 'package:expense_tracker/app/modules/home/controllers/home_controller.dart';
export 'package:expense_tracker/app/modules/splash/controllers/splash_controller.dart';
export 'package:expense_tracker/app/modules/authentication/controllers/congratulation_controller.dart';
export 'package:expense_tracker/app/modules/authentication/controllers/login_controller.dart';
export 'package:expense_tracker/app/modules/authentication/controllers/otp_verification_controller.dart';
export 'package:expense_tracker/app/modules/authentication/controllers/signup_controller.dart';
export 'package:expense_tracker/app/modules/home/controllers/add_expense_controller.dart';

/* ==================================================app routes ===========================================*/

export 'package:expense_tracker/app/routes/app_pages.dart';
export 'package:expense_tracker/app/routes/app_routes.dart';
export 'package:expense_tracker/main.dart';

/*============================================== application screens =====================================*/

export 'package:expense_tracker/my_app.dart';
export 'package:expense_tracker/app/modules/splash/views/splash_screen.dart';
export 'package:expense_tracker/app/modules/authentication/views/login_screen.dart';
export 'package:expense_tracker/app/modules/authentication/views/otp_verification_screen.dart';
export 'package:expense_tracker/app/modules/authentication/views/signup_screen.dart';
export 'package:expense_tracker/app/modules/authentication/widgets/authentication_screen_heading.dart';
export 'package:expense_tracker/app/modules/home/views/home_screen.dart';
export 'package:expense_tracker/app/modules/authentication/views/congratulation_screen.dart';
export 'package:expense_tracker/app/modules/home/views/add_expense_screen.dart';
